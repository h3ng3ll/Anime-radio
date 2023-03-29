

import 'dart:io';

import 'package:anime_radio/src/databases/DatabaseImages/DatabaseImages.dart';
import 'package:anime_radio/src/models/SaveStatus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExternalStorageService {

  final  _dio = Dio();

  Future<SaveStatus> saveImageToGallery(
      String url ,
      BuildContext context,
      DatabaseImages databaseImages
  ) async {

    late Directory? directory ;
    final index = databaseImages.images.indexOf(url);
    /// take only extension of image
    final ext = databaseImages.images[index].split(".").last;

    try {
      if(await  requestPermission(Permission.storage)){

        directory = await getExternalStorageDirectory();

        String path = '';

        final dirPaths = directory!.path.split("/");
        for (int i  = 1  ; i< dirPaths.length; i++ ){
          String folder = dirPaths[i];
          if(folder != "Android") {
            path += "/$folder";
          } else {
            break ;
          }

        }
        path = '$path/DCIM/AnimeRadio';
        directory = Directory(path);

      } else {
        // ignore: use_build_context_synchronously
        return SaveStatus(false, "" , AppLocalizations.of(context)!.storage_permission_have_not_granted) ;
      }

      if(!await directory.exists()) {
         await directory.create();
      }
      if(await directory.exists()) {


        File saveFile = File(""
            "${directory.path}/animeRadio-${databaseImages.genre.name}.$index.$ext"
        );

        Response  response = await _dio.get(
            url,
            options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false ,
            )
        );

        var raf = saveFile.openSync(mode: FileMode.write);

        raf.writeFromSync(response.data);
        await raf.close();

        return SaveStatus(true, "${directory.path}/animeRadio-$index.$ext" ) ;
      }

    } on Exception catch (e) {
      debugPrint("error:  $e");

      if(e is DioError) {
        if(e.error.osError.errorCode == 7) {
          return SaveStatus(
              false,
              "${directory?.path}/animeRadio-$index.$ext" ,
              "${AppLocalizations.of(context)!.no_internet_connection}"
                  "\n${AppLocalizations.of(context)!.failed_to_save_image}"
          ) ;

        }
      }

      return SaveStatus(false, "${directory?.path}/animeRadio-$index.$ext" , e.toString()) ;
    }
    return   SaveStatus(false, "${directory.path}/animeRadio-$index.$ext" , "Unhandled error") ;
  }

  /// check Storage Permission
  Future<bool> requestPermission(Permission permission) async {

    if(await Permission.storage.isGranted){
      return true;
    } else {
      final res = await  Permission.storage.request();
      if(res == PermissionStatus.granted){
        return true;
      } else {
        return false;
      }
    }
  }

}