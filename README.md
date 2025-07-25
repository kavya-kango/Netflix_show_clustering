#  Netflix Movies and TV Shows – Data Analysis & Insights

This repository contains a comprehensive analysis of Netflix’s movie and TV show library. It includes exploratory visualizations, statistical hypothesis testing, and content clustering using Python.

---

##  Dataset Overview

The dataset contains metadata of Netflix titles including:
- Title, Type (Movie/TV Show)
- Cast & Country
- Release Year & Date Added
- Content Rating & Duration
- Genre (`listed_in`) and Audience Category (`target_ages`)

---

##  Project Highlights

###  Data Visualizations
- **Release Trends Over the Years**  
  Comparative line plots of movies and TV shows released yearly.
- **Annual Releases (Last 20 Years)**  
  Countplots for movies and TV shows from the past two decades.
- **Monthly Additions**  
  Distribution of titles added by month.
- **Genre & Age Analysis**  
  Runtime comparisons by audience category (Kids, Older Kids, Teens, Adults).

###  Hypothesis Testing
#### Hypothesis I:
- **H₀**: Kids and older kids' movies are at least two hours long.
- **H₁**: They are significantly shorter.
-  **Result**: Null hypothesis rejected; kids' content is notably shorter.

#### Hypothesis II:
- **H₀**: Movies longer than 90 minutes are not actual “Movies”.
- **H₁**: Movies longer than 90 minutes are labeled as “Movies”.
-  **Result**: Strong statistical evidence confirms longer durations align with “Movie” labels.

###  Clustering & Evaluation
- Hierarchical and K-Means clustering applied to identify patterns.
- Used **Elbow Method** and **Silhouette Score** to determine optimal clusters.
- **26 clusters** identified for meaningful segmentation.
- **Cluster 0** found to contain the most data points.
- Evaluated with:
  - `silhouette_score`
  - `davies_bouldin_score`

---

##  Technologies Used

| Library        | Purpose                          |
|----------------|----------------------------------|
| `pandas`       | Data manipulation                |
| `numpy`        | Statistical calculations         |
| `matplotlib` & `seaborn` | Plotting & visualization   |
| `scikit-learn` | Clustering & metrics             |
| `scipy.stats`  | Hypothesis testing               |
| Google Colab   | Notebook environment             |

---

##  Sample Code Snippet

``python
from scipy import stats
t_val = (M1 - M2) / (sp * np.sqrt(1/n1 + 1/n2))
if t_val < stats.t.ppf(0.025, dof) or t_val > stats.t.ppf(0.975, dof):
    print("Reject H₀") ``

# How to Run
* Clone the repo:

`git clone https://github.com/your-username/netflix-analysis.git`

* Open the notebook in Google Colab or Jupyter.

* Run cells sequentially to reproduce visualizations and analysis.

# Key Findings

* Netflix hosts 5,372 movies and 2,398 TV shows.
* TV-MA is the dominant rating for TV shows.
* Documentaries and Kids’ TV are the most popular genres.
* Seasonal spikes in content addition occur from October to January.
* India is second only to the USA in available titles.

# Contribute

* Feel free to fork, enhance visualizations, or explore deeper with unsupervised learning techniques.
