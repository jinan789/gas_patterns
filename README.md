The data is organized as follows:

1. crawled_codes: this folder contains all the codes that we crawled from Etherscan.

2. GPT_inputs_outputs: this folder contains the input prompts we provided to GPT-4 during each round. The "ablation" folder contains the prompts we used for the ablation section, and the "regular" folder is for the rounds 1 through 8.

3. category_list: this folder contains the lists of categories we made.

4. evaluation_statistics: this folder contains the statistics that we collected and used to make all the figures and tables in the paper. In particular, in the "reference_to_existing_works.txt" file, within the curly brackets (i.e. "{}") are the papers that presented the same pattern as the corresponding one; in addition, within the greater-less-than signs (e.g. "<>") are the papers that presented a tangentially similar pattern to ours but are not quite the same. For the "ablation_results.txt" and "regular_results.txt", each row corresponds to one reported pattern. Within each row, entries are separated by "&," with the first entry being the name of the reported pattern, the second entry being the corresponding file identifier (e.g. 8.2 means the second file, ordered alphabetically, of the round 8. Prefixes like "fse" or "cot" means it is used in the ablation rounds), the third entry being the pattern number (using the numbered identifier as defined under the "category_list" folder). For the "gas_cost_of_patterns.txt" file, we record the amount of consumed gas, together with some other meta-information, for each of the demonstration codes.

5. demo_codes: this folder contains all the codes that we used for demonstrating gas costs of patterns. The naming convention of the files under this folder is that the postfix indicates if the codes are optimized or not ("u" for unoptimized and "o" for optimized), and the number in the middle stands for the patten number.

6. "pattern_report.pdf": this file is the 49-page report that we made to demonstrate patterns.
