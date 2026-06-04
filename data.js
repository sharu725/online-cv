/* Alex Rudolph — resume content, lifted from
   github.com/Xander-Rudolph/online-cv/_data/data.yml
   and lightly tightened for the modern card layout. */
window.RESUME = {
  name: "Alex Rudolph",
  tagline: "Senior DevOps Engineer",
  avatar: "assets/profile.jpg",
  location: "Seattle",
  timezone: "America/Los_Angeles",
  zoneLabel: "Pacific Time",
  citizenship: "US Citizen",
  available: true,
  links: {
    website: "https://alex.rudolphhome.com",
    websiteLabel: "alex.rudolphhome.com",
    linkedin: "https://linkedin.com/in/alexrudolph",
    github: "https://github.com/Xander-Rudolph",
    stackoverflow: "https://stackoverflow.com/users/835448/xanderu",
    discord: "https://discord.gg/D2z44uQ8QJ",
    printPdf: "#print",
    enhancedPdf: "#enhanced"
  },
  summary:
    "Kubernetes, Docker, and Helm expert with a strong aptitude for mentoring, processes, and collaborative problem-solving. Proven track record of optimizing and sustaining systems through automation at minimal cost. Anything can be automated. Experience across Azure and AWS — cloud, edge, and language agnostic — streamlining complex deployment processes while troubleshooting along the way.",
  philosophy: "Anything can be automated.",

  // category keys used by the experience filter
  categories: [
    { key: "all", label: "All" },
    { key: "cloud", label: "Cloud" },
    { key: "cicd", label: "CI/CD" },
    { key: "iac", label: "IaC" },
    { key: "containers", label: "Containers" }
  ],

  experiences: [
    {
      role: "Senior DevOps Engineer",
      company: "FaceFirst",
      locationLabel: "",
      time: "JUNE 2023 — PRESENT",
      current: true,
      cats: ["cicd", "iac"],
      details:
        "Build automation and CI/CD tooling for application builds. Design standardized, language-aware pipelines that detect a repository's makeup and build to each language's best practices — supporting poly/mono repos and a migration off Git submodules onto NuGet packages.",
      stack: ["Windows shop", "Terraform", "On-prem deploys", "GitHub Actions"]
    },
    {
      role: "Senior DevOps Engineer",
      company: "Hanwha Techwin America",
      locationLabel: "San Jose",
      companyLink: "https://github.com/htaic",
      time: "APRIL 2022 — FEB 2024",
      cats: ["cloud", "cicd", "iac", "containers"],
      details:
        "Founding member. Defined the multi-tenant cloud environment, including its security and account structure. Trained teams on Agile via a 3-day interactive seminar and served as scrum / scrum-of-scrums master. Built open-source, templated GitHub pipelines for asynchronous code scanning, auditing, and scalable deployment on K8s, K3s, and Helm.",
      stack: ["AWS multi-tenant", "macOS shop", "Terraform", "Traefik k8s", "GitHub Actions"]
    },
    {
      role: "Senior DevOps Engineer",
      company: "Motorola Solutions Inc",
      locationLabel: "Boston",
      time: "JAN 2021 — APRIL 2022",
      cats: ["cloud", "cicd", "iac"],
      details:
        "Built and deployed PowerShell modules to stand up an SSRS server and Grafana as Azure containers. Designed/implemented the security model for Azure AD and Azure SQL, automated federated-auth testing via the Graph API, and implemented an ExpressRoute virtual network with Azure B2C federated authentication.",
      stack: ["Azure multi-tenant", "Windows shop", "Terraform", "Azure DevOps"]
    },
    {
      role: "DevOps Engineer",
      company: "Sensitech",
      locationLabel: "Beverly",
      time: "DEC 2019 — JAN 2021",
      cats: ["cloud", "iac", "containers"],
      details:
        "Built, deployed and maintained Artifactory and the Atlassian suite on Azure Ubuntu VMs with nginx + Docker and app storage in SMB mounts, all via Terraform. Environments could be spun up in 17 minutes with previous-day backups mounted to restore.",
      stack: ["Azure multi-tenant", "Windows/Linux", "Terraform", "nginx"]
    },
    {
      role: "Tech Lead",
      company: "MFS / Kaygen",
      locationLabel: "Boston",
      time: "MARCH 2019 — DEC 2019",
      cats: ["cicd"],
      details:
        "Troubleshot and debugged production issues, assisted the dev team on design and architecture, and automated PowerShell + SQL workflows for multiple teams to reduce workload.",
      stack: ["On-prem virtualized", "Windows shop", "PowerShell", "Maestro"]
    },
    {
      role: "Senior Support Engineer",
      company: "SimCorp",
      locationLabel: "Boston",
      time: "SEP 2016 — FEB 2019",
      cats: ["cloud", "cicd"],
      details:
        "Triaged on-prem and Azure issues; automated application prerequisites and installs using PowerShell runbooks that validated and configured IIS, SQL, and Windows Optional Features with environment-agnostic scripts.",
      stack: ["Hybrid Azure/On-prem", "Windows shop", "PowerShell", "IIS"]
    },
    {
      role: "Tech & Ops Analyst III",
      company: "Santander US",
      locationLabel: "Dorchester",
      time: "OCT 2014 — SEP 2016",
      cats: ["cicd"],
      details:
        "Built and maintained .NET and VB code for multiple business units and designed automations for key bank processes — standalone and Office-integrated VB apps that auto-solved and responded to requests.",
      stack: ["On-prem hardware", "Windows shop", "Visual Basic / .NET"]
    }
  ],

  projects: [
    {
      title: "MediaKube Redux",
      link: "https://github.com/Xander-Rudolph/Mediakube-redux",
      tagline: "Open-source Kubernetes cluster for media",
      icon: "fa-cubes"
    },
    {
      title: "Xanderu Helpers",
      link: "https://www.powershellgallery.com/packages/xanderu.helpers/1.0.0",
      tagline: "Open-source PowerShell pipeline creator",
      icon: "fa-terminal"
    },
    {
      title: "Hanwha Vision",
      link: "https://github.com/htaic",
      tagline: "Apache-licensed enterprise repos for GitHub Actions & Helm",
      icon: "fa-building"
    },
    {
      title: "Mossworks Labs",
      link: "https://github.com/Mossworks-Labs",
      tagline: "Open-source MCP servers & infrastructure for AI-assisted content production",
      icon: "fa-flask"
    }
  ],
  projectsIntro:
    "Where possible I keep my code openly available for anyone to contribute to or suggest improvements on. If we aren't growing and learning, we are dying.",

  skills: [
    { name: "Windows", level: 99, cat: "platform" },
    { name: "CI/CD", level: 95, cat: "cicd" },
    { name: "Bash", level: 95, cat: "lang" },
    { name: "Kubernetes", level: 95, cat: "containers" },
    { name: "Helm", level: 95, cat: "containers" },
    { name: "GitHub Actions", level: 95, cat: "cicd" },
    { name: "Docker", level: 95, cat: "containers" },
    { name: "Terraform", level: 93, cat: "iac" },
    { name: "Automation (Jenkins, Ansible…)", level: 93, cat: "cicd" },
    { name: "Azure", level: 90, cat: "cloud" },
    { name: "Linux (Alpine, Debian, Ubuntu)", level: 90, cat: "platform" },
    { name: "Atlassian Suite", level: 90, cat: "platform" },
    { name: "SQL (Postgres, MSSQL, RDS)", level: 85, cat: "lang" },
    { name: "Source Control (TFS/SVN/Git)", level: 80, cat: "cicd" },
    { name: "Reporting (Grafana, Prometheus)", level: 80, cat: "platform" },
    { name: "AWS", level: 60, cat: "cloud" }
  ],

  education: [
    { degree: "MBA, Information Systems", school: "Southern New Hampshire University", time: "2010 — 2011" },
    { degree: "BS, Technical Management", school: "Southern New Hampshire University", time: "2008 — 2009" },
    { degree: "AS, Small Business Management", school: "New Hampshire Community College", time: "2004 — 2008" }
  ],

  interests: [
    { item: "DevOps", link: "" },
    { item: "Automation (CI/CD)", link: "https://resources.github.com/ci-cd/" },
    { item: "AI / Machine Learning", link: "https://ai.engineering.columbia.edu/ai-vs-machine-learning/" },
    { item: "Infrastructure as Code", link: "https://learn.microsoft.com/en-us/devops/deliver/what-is-infrastructure-as-code" }
  ],

  languages: [{ idiom: "English", level: "Native" }]
};
