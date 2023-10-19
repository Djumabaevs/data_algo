
  static Future<void> downloadFilesFromUrl(
    List<String> urls,
    BuildContext ctx,
  ) async {
    // Added helper function to extract file extension from URL
    String getFileExtension(String url) {
      var uri = Uri.parse(url);
      var pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        var lastSegment = pathSegments.last;
        var dotIndex = lastSegment.lastIndexOf('.');
        if (dotIndex != -1) {
          return lastSegment.substring(dotIndex);
        }
      }
      return '';
    }

    if (kIsWebSafe) {
      for (final url in urls) {
        var data = await Client().get(Uri.parse(url));
        print(
            'Data fetched from $url with size: ${data.bodyBytes.length} bytes'); // Logging
        var bytes = data.bodyBytes;
        var fileName = const Uuid().v1() +
            getFileExtension(url); 
        print('Trying to save file with name: $fileName'); // Logging
        await FileSaver.instance.saveFile(name: fileName, bytes: bytes);
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Successfully downloaded')));
    } else {
      final status = await Permission.storage.request();

      if (status.isGranted) {
        for (final url in urls) {
          var data = await Client().get(Uri.parse(url));
          print(
              'Data fetched from $url with size: ${data.bodyBytes.length} bytes'); // Logging
          var bytes = data.bodyBytes;
          var fileName = const Uuid().v1() +
              getFileExtension(url); 
          print('Trying to save file with name: $fileName');
          await FileSaver.instance.saveFile(name: fileName, bytes: bytes);
        }

        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Successfully downloaded')));
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
            content: Text('No permission granted to save file')));
      }
    }
  }

    static Future<void> downloadFileFromBytes(
      Uint8List bytes, String fileExtension, BuildContext ctx) async {
    if (!fileExtension.startsWith('.')) {
      fileExtension = '.$fileExtension';
    }
    fileExtension = fileExtension.split('?')[0];

    if (kIsWebSafe) {
      await FileSaver.instance
          .saveFile(name: '${const Uuid().v1()}$fileExtension', bytes: bytes);
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Successfully downloaded')));
    } else {
      final status = await Permission.storage.request();

      if (status.isGranted) {
        await FileSaver.instance
            .saveFile(name: '${const Uuid().v1()}$fileExtension', bytes: bytes);

        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Successfully downloaded')));
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
            content: Text('No permission granted to save file')));
      }
    }
  }
  