# App_name

A Description of the app

### Changing the App Name
- Open in vscode
- Use `crtl` + `shift` + `F` to find all replace in all files
- Follow the steps
  - Change the `com.company.app_name` to com.`your_company.your_app_name` that you register in `firebase` panel
  - Change the `app_name` to `your_app_name`, Use `Aa` enabled to change only the small leter version
  - Change the `App_name` to `you_app_name_public_name`

- Setting Up IOS
- Download the `GoogleSerive-info.plist` for ios and paste/replace it inside
- ios > Runner
- Change the `reverse-client-id` from the `GoogleSerive-info.plist` inside the `info.plist` file
- Setting Up Android
- Download the `google-services.json` and replace it inside the android > app >google-services.json file

- Then run `flutter pub get` to install the packages
- Then run `flutter build apk` to generate android apk
- Then run `flutter build ios` to generate ios



### Default Firebase rule
For tracking the registered users inside the app
```
{
  "rules": {
    "regusers":{
      "$uid":{
       	".read": "auth != null && auth.uid == $uid",
	    ".write": "auth != null && auth.uid == $uid"
      }
    }
  }
}
```