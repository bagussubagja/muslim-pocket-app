class ConstantURL {
  String devEmail = 'bagussubagja74@gmail.com';
  String emptyAvatar =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png';
  String contentNotFound =
      'https://matob.web.id/random/wp-content/uploads/sites/2/2021/12/error-404.jpg';
  String doaEndpoint = 'https://doa-doa-api-ahmadramadhan.fly.dev/api/';
  String ayatOfTheDayEndpoint =
      'https://api.banghasan.com/quran/format/json/acak';

  String haditsEndpoint = 'https://hadis-api-id.vercel.app/hadith';

  haditsUrlEndpoint(String narator, int page) {
    return 'https://hadis-api-id.vercel.app/hadith/$narator/?page=$page&limit=20';
  }

  nearbyMosqueEndpoint(String lat, String long) {
    return 'https://www.google.co.id/maps/search/masjid+terdekat/@$lat,$long,15z/data=!3m1!4b1';
  }

  tafsirEndpoint(int surah) {
    return 'https://equran.id/api/tafsir/$surah';
  }

  youtubeAPIEndpoint(String channelId, String key, int result) {
    return 'https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=$channelId&order=date&key=$key&maxResults=$result';
  }
}
