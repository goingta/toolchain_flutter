class ItemModel {
  String id;
  String name;
  String tid;
  String type;
  String alias;
  String desc;
  String gitlab;
  String owner;
  String logo;
  String branch;

  ItemModel(
      {this.id,
      this.name,
      this.tid,
      this.alias,
      this.desc,
      this.gitlab,
      this.owner,
      this.logo,
      this.branch});

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        tid = json['tid'],
        type = json['type'],
        alias = json['alias'],
        desc = json['desc'],
        gitlab = json['gitlab'],
        owner = json['owner'],
        logo = json['logo'],
        branch = json['branch'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tid': tid,
        'type': type,
        'alias': alias,
        'desc': desc,
        'gitlab': gitlab,
        'owner': owner,
        'logo': logo,
        'branch': branch
      };
}
