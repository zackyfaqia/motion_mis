cd flutter
flutter build web --release
rm -rf ../docs
mkdir ../docs
mv ./build/web/* ../docs