class Global {
  static String env = "dev";

  static String schema;
  static final corpId = 'ww41abef44dc00e8c4';
  static String agentId;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    //hao123
    switch (env) {
      case "dev":
        schema = "wwauth41abef44dc00e8c4000021";
        agentId = "1000021";
      break;
      case "qa":
        schema = "wwauth41abef44dc00e8c4000016";
        agentId = "1000016";
      break;
      case "pre":
        schema = "wwauth41abef44dc00e8c4000017";
        agentId = "1000017";
      break;
      case "prd":
        schema = "wwauth41abef44dc00e8c4000015";
        agentId = "1000015";
      break;
    }
    //Sphinx
    // switch (env) {
    //   case "dev":
    //     schema = "wwauth41abef44dc00e8c4000049";
    //     agentId = "1000049";
    //   break;
    //   case "qa":
    //     schema = "wwauth41abef44dc00e8c4000049";
    //     agentId = "1000049";
    //   break;
    //   case "pre":
    //     schema = "wwauth41abef44dc00e8c4000050";
    //     agentId = "1000050";
    //   break;
    //   case "prd":
    //     schema = "wwauth41abef44dc00e8c4000050";
    //     agentId = "1000050";
    //   break;
    // }
  }
}
