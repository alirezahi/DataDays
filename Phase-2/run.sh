declare -a arr=("cat1" "cat2" "cat3")

read -p "Enter Train Data Path: " train_path
read -p "Enter Test Data Path: " test_path

for i in "${arr[@]}"
do
    echo "Estimating $i started ..."
    python3 main2.py "$i" "$train_path"
    python3 test.py "$i" "$test_path"
    echo "Estimating $i finished!"
done

python3 combiner.py