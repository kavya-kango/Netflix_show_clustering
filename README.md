#  Netflix Content Analysis & Clustering Project

This repository contains code and insights from a comprehensive data analysis on Netflix titles, exploring viewing trends, content characteristics, and clustering patterns.

---

##  Project Overview

This project performs:

-  Data cleaning and preprocessing
-  Exploratory data analysis (EDA)
-  Hypothesis testing using t-tests
-  Clustering analysis (Hierarchical & K-Means)
-  Evaluation with Silhouette and Davies–Bouldin Scores

---

##  Highlights

- Movies for kids and older kids are significantly **shorter than 2 hours**
- Movies over 90 minutes tend to be actual **“Movie” type** content
- Clear clustering emerges in content characteristics
- U.S. and India dominate Netflix’s regional catalog

---

##  Technologies Used

| Tool / Library       | Description                          |
|----------------------|--------------------------------------|
| `pandas`             | Data manipulation and grouping       |
| `numpy`              | Statistical computations             |
| `matplotlib` / `seaborn` | Visualization                     |
| `scikit-learn`       | Clustering, metrics, evaluation      |
| `scipy.stats`        | Hypothesis testing                   |
| Google Colab         | Cloud-based development              |

---

##  Hypothesis Testing

###  Test 1: Duration of Kids & Older Kids Movies

```python
# t-test for duration difference
t_val = (M1 - M2) / (sp * np.sqrt(1/n1 + 1/n2))
if t_val < stats.t.ppf(0.025, dof) or t_val > stats.t.ppf(0.975, dof):
    print("Reject null hypothesis")
