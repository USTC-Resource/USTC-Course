#echo "generating zip files..."
#python3 utils/genZipFile.py #-r 

echo "checking big files(>100M) and removing them..."
python3 utils/checkBigFile.py 

echo "generating readme"
python3 utils/genReadme.py  -p . -d 2  

echo "generating index html files..."
python3 utils/genIndex.py

echo "git add ..."
git add *

