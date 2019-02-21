declare -a arr=("cat1" "cat2" "cat3")

for i in "${arr[@]}"
do
    echo "Estimating $i started ..."
    python3 main2.py "$i"
    python3 test.py "$i"
    echo "Estimating $i finished!"
done

python3 combiner.py