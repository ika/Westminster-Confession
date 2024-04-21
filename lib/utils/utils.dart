List<String> westindex = [
  "Of the Holy Scriptures",
  "Of God and of the Holy Trinity",
  "Of God's Eternal Decree",
  "Of Creation",
  "Of Divine Providence",
  "Of the Fall of Man, Of Sin, and of the Punishment Thereof",
  "Of God's Covenant with Man",
  "Of Christ the Mediator",
  "Of Free Will",
  "Of Effectual Calling",
  "Of Justification",
  "Of Adoption",
  "Of Sanctification",
  "Of Saving Faith",
  "Of Repentance Unto Life",
  "Of Good Works",
  "Of The Perseverance of the Saints",
  "Of the Assurance of Grace and Salvation",
  "Of the Law of God",
  "Of Christian Liberty and Liberty of Conscience",
  "Of Religious Worship and the Sabbath Day",
  "Of Lawful Oaths and Vows",
  "Of the Civil Magistrate",
  "Of Marriage and Divorce",
  "Of the Church",
  "Of the Communion of Saints",
  "Of the Sacraments",
  "Of Baptism",
  "Of the Lord's Supper",
  "Of Church Censures",
  "Of Synods and Councils",
  "Of the State of Men after Death, and of the Resurrection of the Dead",
  "Of the Last Judgment"
];

class Utils {
  Future<List<String>> getTitleList() async {
    return westindex;
  }
}

String replaceNumbers(String txt) {
  return txt.replaceAll(RegExp(r"#\d+"), "");
}

// text and length
String prepareText(String txt, int len) {
  txt = replaceNumbers(txt);
  if (txt.length > len) {
    txt = txt.substring(0, len);
  }
  return txt;
}
