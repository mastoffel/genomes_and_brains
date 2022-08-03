import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# mammal brain, Smaers et al.
# load txt file
brains = pd.read_csv('data/brain_size2.txt', sep='\t')
brains

# import genome data (genomesizedatabase)  
genomes = pd.read_excel('data/genome_size.xls')
genomes['Species'] = genomes['Species'].str.replace(' ', '_')

# import AnAge data
lh = pd.read_table('data/AnAge.txt')

# combine Genus and Species into Species column
lh['Species'] = lh['Genus'] + '_' + lh['Species']

# join genomes and brains2 by 'Species'
gb = genomes.merge(brains, on='Species')

# join gb and lh by 'Species'
gb = gb.merge(lh, on='Species')

# select columns 
gb = gb[['Species', 'Common name', 'Family_x', 'Order_x',
         'C-value', 'Brain', 'Body', 'Female maturity (days)',
         'Male maturity (days)', 'Weaning (days)', 'Maximum longevity (yrs)']]

# make column for brain to body ratio
gb['Brain_Body'] = gb['Brain'] / gb['Body']

# make C-value and Brain float64
gb['C-value'] = gb['C-value'].astype(float)
gb['Brain'] = gb['Brain'].astype(float)

# plot C-value vs. Brain with regression line
# color by "Family"
sns.lmplot('Male maturity (days)', 'Brain_Body', data=gb)
plt.show()

# 10 to the power of 16
flops_lifetime = 10e16 * 3600 * 24 * 356 * 20
# scientific notation for flops_lifetime
