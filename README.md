# Olympic-Success-Analysis
A comprehensive SQL-based analysis of historical Olympic data to identify key drivers of success and provide strategic recommendations.
# Decoding Olympic Success: A SQL-Based Analysis

[View the Interactive Dashboard Here](https://<Your-GitHub-Username>.github.io/Olympic-Success-Analysis/dashboard/Dashboard.html)

**Project Overview**

This project is a comprehensive analysis of historical Olympic data (1896-2016), undertaken for a fictional National Olympic Committee of a Developing Nation (NOC-DN). The objective was to move beyond anecdotal evidence and provide a clear, data-backed strategy to optimize investment for a higher return in the form of Olympic medals. The analysis uses SQL for data cleaning, transformation, and hypothesis testing, culminating in a set of strategic recommendations.

**Key Questions & Hypotheses**

The analysis was guided by several key questions and four core hypotheses:

1.  **The Physique of a Champion:** Do physical attributes like height correlate with winning medals?
2.  **The Age Paradox:** Does youth always have the advantage in physically demanding sports like Gymnastics?
3.  **Economic Power and the Podium:** How strongly does a nation's GDP predict its medal count?
4.  **The Globalization of Sport:** Are emerging nations closing the competitive gap on historical powerhouses?

**Key Findings & Visualizations**

Our analysis confirmed that while economic power is a dominant factor, it is not destiny. Experience can outweigh youth, and athletic excellence is becoming more globalized.

| Hypothesis | Finding | Supporting Visualization |
| **Economic Power** | Nations with an above-median GDP won **5x more medals** on average than those below it. 
| **Globalization** | Emerging Asian nations have drastically increased their sports diversity, narrowing the gap with Western powers.
| **The Age Paradox** | In Gymnastics, medalists are slightly **older** than non-medalists, suggesting experience is key.

**The Strategic Recommendation: Specialization over Generalization**

The core insight from the analysis is that for a developing nation, the most viable path to success is **Strategic Specialization**. By focusing resources on a few high-opportunity sports, a country can achieve an efficiency (Medal Conversion Rate) that far outpaces its economic standing.

**Tools Used**

**Database:** Microsoft SQL Server
**Data Visualization:** Chart.js, HTML/CSS
**Reporting:** Microsoft PowerPoint, Word/PDF
**Version Control:** Git & GitHub

**How to Replicate This Project**

1.  The raw dataset (`athlete_events.csv`) can be downloaded from [Kaggle](https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results).
2.  The SQL scripts in the `sql_scripts/` folder should be run in numerical order.
3.  The final interactive dashboard is located in the `dashboard/` folder.
