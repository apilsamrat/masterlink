class ShortData {
    int status;
    String fullLink;
    DateTime date;
    String shortLink;
    String title;

    ShortData({
        required this.status,
        required this.fullLink,
        required this.date,
        required this.shortLink,
        required this.title,
    });

    factory ShortData.fromJson(Map<String, dynamic> json) => ShortData(
        status: json["status"],
        fullLink: json["fullLink"],
        date: DateTime.parse(json["date"]),
        shortLink: json["shortLink"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "fullLink": fullLink,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "shortLink": shortLink,
        "title": title,
    };
}
