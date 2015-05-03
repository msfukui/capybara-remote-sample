# Capybara Remote Sample

![カピバラ](http://pds2.exblog.jp/pds/1/201208/05/64/f0134464_14162236.jpg "カピバラ")

## Description (What's this?)

Capybara + Rspec を Selenium で remote 実行するサンプルです。

PhantomJS(Poltergeist) での Ajax 関連のテストが極めて不安定だったので、調べ物を兼ねて作りました。

Capybara Webkit はセットアップからしてつらいので動作は確認したもののあきらめています...。

でも結局あまりつらみには変わりないかも..。

## Tested Environments

* Client  
    ScientificLinux 6.6 (VirtualBox + Vagrant Guest)  
        Ruby 2.2.2 (rbenv)  
            Rspec 3.2.0  
            Capybara 2.4.4

* Remote Server  
    Windows 8.1  
        FireFox 37.0.2  
        Internet Explorer11 11.0.9600.17728  
        Google Chrome 42.0.2311.135  
    Java 1.8.0_45  
        Selenium RC Server 2.45.0

## Untested Environments

* Remote Server  
    MacOS X  
        Safari

## Usage

### Setup

git clone した先のディレクトリで bundle install を実行してください。

```
$ bundle install --path=vendor/bundle
```

### Run

普通に rspec を実行します。

```
$ bundle exec rspec
```

テスト実行の前には、事前に remote server 側で JRE or JDK 及び http://www.seleniumhq.org/download/ から Selenium Server (Selenium RC Server) を download して起動しておく必要があります。

```
> java -jar selenium-server-standalone-2.45.0.jar
```

Cygwin + Windows の環境などで、表示される文字列を UTF-8 にしたい場合は、以下の様に実行しておくとよいと思います。

```
$ java -Dfile.encoding=UTF-8 -jar selenium-server-standalone-2.45.0.jar
```

また、テスト対象のブラウザに応じて remote server 側で以下のセットアップが必要です。

* FireFox  
    インストールするだけで OK.

* Google Chrome  
    https://sites.google.com/a/chromium.org/chromedriver/downloads から ChromeDriver を download して PATH の通ったフォルダに入れます。

* Internet Explorer (Windows の場合のみ可)  
    http://www.seleniumhq.org/download から 32bit 版 or 64bit 版の Internet Explorer Driver Server を download して PATH の通ったフォルダに入れます。  
    またテストの実行前に、remote server 側の IE のインターネット オプションの セキュリティ タブで全てのゾーンの保護モードの設定を無効にしておいてください。（そうしないとテストが必ず失敗します。）

* Safari (MacOS X の場合のみ可)  
    http://www.seleniumhq.org/download から Safari Server を download して PATH の通ったディレクトリに入れます。（環境がないので未検証です。ごめんなさい。）

## Constitution

```
capybara-remote-sample/
|--.gitignore
|--.rspec
|--Gemfile
|--README.md
|--spec/
   |--features/
   |  |--sample_spec.rb
   |--spec_helper.rb
   |--supports/
      |--capybara_sample_helper.rb
      |--have_searched_result_in_google.rb
```

* spec/spec_helper.rb  
    Rspec + Capybara の実行に必要な共通設定を入れたファイルです。  
    Rspec の実行時設定が必要な場合は、こちらでごにょごにょするとよいと思います。

* spec/features/sample_spec.rb  
    Google さんにアクセスして title を検査するだけのテストと、Google さんにアクセスして Capybara で検索して検索に成功したかどうかを検査するだけのテストのサンプルです。  
    テストを書いてこのディレクトリ配下に xxx_spec.rb の名前で保存すると rspec がまとめてテストを実行してくれます。

* spec/supports/  
    Custom Matcher や共通で使う fill_in の設定などを入れておくディレクトリです。  
    ここに入った *.rb ファイルは rspec 実行時に自動で require されます。

## Setting

実行前に以下の環境変数を設定することでテストの挙動を変更できます。

* RUN_REMOTE_BROWSER  
    テスト対象のブラウザを指定します。既定値は firefox です。  
    ブラウザは firefox, chrome, ie, safari を指定できます。  
    設定がこれら以外の文字列の場合は firefox でテストを実行します。

* RUN_REMOTE_HOST  
    remote server のホスト名またはIPアドレスを指定します。既定値は localhost です。

* RUN_REMOTE_PORT  
    remote server のポート番号を指定します。既定値は 4444 です。

こんな感じで実行するとよいと思います。

```
$ RUN_REMOTE_BROWSER=ie RUN_REMOTE_HOST=192.168.1.1 bundle exec rspec
```

## Notes

* InternetExplorerDriver を IE11 環境で動作させる場合は、特殊なレジストリ・キーの設定が必要な模様です。詳細は [InternetExplorerDriver - selenium](https://code.google.com/p/selenium/wiki/InternetExplorerDriver) のページを参照してください。  
    IE11 は正式にはサポートされているわけではなさそうですが、手元の Windows8.1 環境との組み合わせでは、 Suggest 箇所の動作は遅いものの、サンプルについて一応動作することを確認しています。

## License

[MIT License](http://opensource.org/licenses/MIT "MIT License") です。

## 参考リンク

* [jnicklas/capybara - GitHub](https://github.com/jnicklas/capybara)

* [Documentation for jnicklas/capybara (master) Index](http://www.rubydoc.info/github/jnicklas/capybara/master/index)

* [InternetExplorerDriver - selenium](https://code.google.com/p/selenium/wiki/InternetExplorerDriver)

* [RSpec3 / Capybara / Capybara-Webkit チートシート - Rails Webook](http://ruby-rails.hatenadiary.com/entry/20150103/1420280252)

* [RSpecでカスタムマッチャを作る - Qiita](http://qiita.com/kozy4324/items/9a6530736be7e92954bc)

* [Capybara 2 にアップグレード - Qiita](http://qiita.com/quattro_4/items/64c5abdf86c7b40d40b1)

* [Capybara で within した場所や find したノードに枠を付けてくれるやつ作った - Thanks Driven Life](http://gongo.hatenablog.com/entry/2013/08/01/000958)

## その他

カピバラもかわいいけどバクもよい。マレーバクとてもよい。

![マレーバク](http://upload.wikimedia.org/wikipedia/commons/3/3e/Malayan_Tapir_001.jpg "マレーバク")
