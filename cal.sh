#!/usr/bin/env bash
# set -x

#
# generate year calendar for printing on paper
# 自己动手，丰衣足食
#

script_file=${BASH_SOURCE[0]}
script_name=$(basename "${script_file}")
script_root=$(cd $(dirname "${script_file}") && pwd)

year=${1:-$(date '+%Y')}

output_html=/tmp/${year}.html

if ! which gcal &> /dev/null; then
    brew install gcal
fi

echo '<pre><code>' > ${output_html}
gcal --starting-day=1 ${year} | \
    sed -e 's/^/      /g' \
        -e 's/[<>]/ /g' \
        -e 's/Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su/ 一 二 三  四 五  六 天      一 二 三  四 五  六 天      一 二 三  四 五  六 天/' \
        -e 's/            January                   February                   March/        一月                      二月                      三月/g' \
        -e 's/            April                      May                       June/       四月                      五月                      六月/g' \
        -e 's/            July                     August                  September/      七月                      八月                      九月/g' \
        -e 's/            October                   November                  December/        十月                      十一月                     十二月/g' \
        >> ${output_html}
echo '</pre></code>' >> ${output_html}

echo "Saved in ${output_html}."
echo "Use browser 'print' to print as pdf or to paper."

open "${output_html}"
