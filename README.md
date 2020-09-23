# toolchain_flutter

基于蒲公英，用 flutter 写的一个工具链



### 原生提供Flutter调用的能力

#### goingta.flutter.io/share

- gotoWechat 跳转小程序

| 参数名      | 类型   | 是否必填 | 参数说明      | 备注                                                     |
| :---------- | :----- | -------- | :------------ | :------------------------------------------------------- |
| appid       | String | 是       | 小程序原始 ID | /                                                        |
| programType | String | 是       | 小程序环境    | test： 开发版<br />preview： 体验版<br />release：正式版 |

- sendReqToWechat 微信分享

| 参数名          | 类型    | 是否必填               | 参数说明                                                     | 备注                                                     |
| :-------------- | :------ | ---------------------- | :----------------------------------------------------------- | :------------------------------------------------------- |
| type            | String  | 是                     | 分享类型                                                     | webPage：网页分享<br />miniProgram：小程序分享           |
| programType     | String  | 针对小程序分享类型，是 | 只针对小程序分享类型，分享小程序的环境                       | test： 开发版<br />preview： 体验版<br />release：正式版 |
| pageUrl         | String  | 是                     | 小程序分享类型：兼容低版本的网页链接<br />网页分享类型：html 链接 | /                                                        |
| userName        | String  | 针对小程序分享类型，是 | 只针对小程序分享类型，小程序原始id                           | /                                                        |
| path            | String  | 针对小程序分享类型，是 | 只针对小程序分享类型，小程序页面路径；对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar" | /                                                        |
| hdImageData     | String  | 针对小程序分享类型，是 | 只针对小程序分享类型，iOS 特有参数。小程序新版本的预览图，Android 对于此参数不做处理 | /                                                        |
| withShareTicket | Boolean | 针对小程序分享类型，是 | 只针对小程序分享类型，是否使用带shareTicket的分享            | /                                                        |
| title           | String  | 是                     | 消息标题                                                     | /                                                        |
| description     | String  | 是                     | 消息描述                                                     | /                                                        |
| mediaTagName    | String  | 是                     | mediaTagName                                                 | /                                                        |

