/* Main.jsx — career profile, filterable experience timeline, projects, animated skills */
const { useState: useStateM, useEffect: useEffectM, useRef: useRefM, useMemo: useMemoM } = React;

function SectionHead({ id, title }) {
  return (
    <div className="section-head">
      <h2 className="section-title" id={id}>{title}</h2>
      <span className="section-rule"></span>
    </div>
  );
}

function CareerProfile({ d }) {
  // highlight the philosophy line inside the summary
  const parts = d.summary.split(d.philosophy);
  return (
    <section className="section" id="about">
      <SectionHead title="Career Profile" />
      <p className="summary">
        {parts[0]}
        <span className="hl">{d.philosophy}</span>
        {parts[1]}
      </p>
    </section>
  );
}

function ExperienceCard({ e, open, onToggle, hidden }) {
  return (
    <div className={"exp" + (e.current ? " current" : "") + (open ? " open" : "") + (hidden ? " hidden" : "")}>
      <span className="exp-dot"></span>
      <div className="exp-card" onClick={onToggle}>
        <div className="exp-top">
          <p className="exp-role">
            {e.role}
            {e.current && <span className="badge-now">● Now</span>}
          </p>
          <span className="exp-time">{e.time}</span>
        </div>
        <p className="exp-co">
          {e.companyLink ? (
            <a href={e.companyLink} target="_blank" rel="noopener" onClick={(ev) => ev.stopPropagation()}>{e.company}</a>
          ) : e.company}
          {e.locationLabel ? " · " + e.locationLabel : ""}
        </p>
        <div className="exp-body">
          <p className="exp-desc">{e.details}</p>
          <div className="tag-row">
            {e.stack.map((s, i) => <span className="tag" key={i}>{s}</span>)}
          </div>
        </div>
        <p className="exp-expand">
          <i className="fas fa-chevron-down"></i> {open ? "Show less" : "Show details & stack"}
        </p>
      </div>
    </div>
  );
}

function Experience({ d }) {
  const [filter, setFilter] = useStateM("all");
  const [openIdx, setOpenIdx] = useStateM(0);
  const counts = {};
  d.categories.forEach((c) => {
    counts[c.key] = c.key === "all"
      ? d.experiences.length
      : d.experiences.filter((e) => e.cats.includes(c.key)).length;
  });
  return (
    <section className="section" id="experience">
      <SectionHead title="Experience" />
      <div className="filters">
        {d.categories.map((c) => (
          <button
            key={c.key}
            className={"pill" + (filter === c.key ? " on" : "")}
            onClick={() => setFilter(c.key)}
          >
            {c.label}<span className="n">{counts[c.key]}</span>
          </button>
        ))}
      </div>
      <div className="timeline">
        {d.experiences.map((e, i) => {
          const show = filter === "all" || e.cats.includes(filter);
          return (
            <ExperienceCard
              key={i}
              e={e}
              hidden={!show}
              open={openIdx === i}
              onToggle={() => setOpenIdx(openIdx === i ? -1 : i)}
            />
          );
        })}
      </div>
    </section>
  );
}

function Projects({ d }) {
  return (
    <section className="section" id="projects">
      <SectionHead title="Projects" />
      <p className="proj-intro">{d.projectsIntro}</p>
      <div className="proj-grid">
        {d.projects.map((p, i) => (
          <a className="proj" key={i} href={p.link} target="_blank" rel="noopener">
            <span className="proj-ico"><i className={"fas " + p.icon}></i></span>
            <span>
              <p className="proj-title">{p.title} <i className="fas fa-arrow-up-right-from-square"></i></p>
              <p className="proj-tag">{p.tagline}</p>
            </span>
          </a>
        ))}
      </div>
    </section>
  );
}

const SK_ACCENTS = {
  oxide: { "--skill-fill": "linear-gradient(90deg,var(--oxide-500),var(--oxide-400))", "--skill-solid": "var(--oxide-500)" },
  mono:  { "--skill-fill": "linear-gradient(90deg,var(--slate-500),var(--slate-400))", "--skill-solid": "var(--slate-500)" },
  duo:   { "--skill-fill": "linear-gradient(90deg,var(--oxide-500),var(--coral-500))", "--skill-solid": "var(--oxide-500)" },
};

const SK_TIERS = [
  { key: 0, label: "Expert", min: 95 },
  { key: 1, label: "Advanced", min: 85 },
  { key: 2, label: "Proficient", min: 75 },
  { key: 3, label: "Working knowledge", min: 0 },
];

function useReveal() {
  const ref = useRefM(null);
  const [shown, setShown] = useStateM(false);
  useEffectM(() => {
    const el = ref.current;
    if (!el) return;
    const io = new IntersectionObserver(
      (es) => es.forEach((en) => { if (en.isIntersecting) { setShown(true); io.disconnect(); } }),
      { threshold: 0.15 }
    );
    io.observe(el);
    const tid = setTimeout(() => setShown(true), 1200); // fallback: covers print / no-scroll
    return () => { io.disconnect(); clearTimeout(tid); };
  }, []);
  return [ref, shown];
}

function Skills({ d, t }) {
  const [ref, shown] = useReveal();
  const style = (t.skillStyle || "Bars").toLowerCase();
  const sort = (t.skillSort || "Level").toLowerCase();
  const cols = Number(t.skillCols || 2);
  const showPct = t.showPercent !== false;
  const accentKey = (t.skillFill || "Oxide").toLowerCase().replace("duotone", "duo");
  const accent = SK_ACCENTS[accentKey] || SK_ACCENTS.oxide;

  const items = useMemoM(() => {
    const a = d.skills.map((s, i) => ({ ...s, _i: i }));
    if (sort === "level") a.sort((x, y) => y.level - x.level);
    else if (sort === "group") a.sort((x, y) => (x.cat || "").localeCompare(y.cat || "") || y.level - x.level);
    return a;
  }, [sort, d.skills]);

  return (
    <section className="section" id="skills" ref={ref}>
      <SectionHead title="Skills & Proficiency" />
      <div className="skills-wrap" style={accent}>

        {style === "bars" && (
          <div className="sk-grid sk-bars" style={{ gridTemplateColumns: `repeat(${cols},minmax(0,1fr))` }}>
            {items.map((s, i) => (
              <div className="skill" key={i}>
                <div className="sk-top">
                  <span className="sk-name">{s.name}</span>
                  {showPct && <span className="sk-pct">{s.level}%</span>}
                </div>
                <div className="sk-track">
                  <div className="sk-fill" data-level={s.level}
                       style={{ width: shown ? s.level + "%" : "0%", transitionDelay: i * 35 + "ms" }}></div>
                </div>
              </div>
            ))}
          </div>
        )}

        {style === "segments" && (
          <div className="sk-grid sk-seg-wrap" style={{ gridTemplateColumns: `repeat(${cols},minmax(0,1fr))` }}>
            {items.map((s, i) => {
              const N = 12, lit = Math.round((s.level / 100) * N);
              return (
                <div className="skill" key={i}>
                  <div className="sk-top">
                    <span className="sk-name">{s.name}</span>
                    {showPct && <span className="sk-pct">{s.level}%</span>}
                  </div>
                  <div className="sk-seg-row">
                    {Array.from({ length: N }).map((_, j) => (
                      <span key={j}
                        className={"sk-seg" + (shown && j < lit ? " on" : "")}
                        style={{ transitionDelay: (i * 25 + j * 22) + "ms" }}></span>
                    ))}
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {style === "rings" && (
          <div className="sk-rings" style={{ gridTemplateColumns: `repeat(${Math.max(cols, 3)},minmax(0,1fr))` }}>
            {items.map((s, i) => (
              <div className="ring-item" key={i}>
                <div className="ring" data-level={s.level}
                     style={{ "--p": shown ? s.level : 0, transitionDelay: i * 40 + "ms" }}>
                  <span>{showPct ? s.level + "%" : ""}</span>
                </div>
                <span className="ring-name">{s.name}</span>
              </div>
            ))}
          </div>
        )}

        {style === "tags" && (
          <div className="sk-tags">
            {SK_TIERS.map((tier) => {
              const inTier = items.filter((s) =>
                s.level >= tier.min && (tier.key === 0 || s.level < SK_TIERS[tier.key - 1].min)
              );
              if (!inTier.length) return null;
              return (
                <div className="sk-bucket" key={tier.key}>
                  <div className="sk-bucket-label">{tier.label}<span className="ln"></span><span className="ct">{inTier.length}</span></div>
                  <div className="sk-chips">
                    {inTier.map((s, i) => (
                      <span className={"sk-chip tier-" + tier.key} key={i}>
                        <span className="dot"></span>{s.name}
                        {showPct && <span className="p">{s.level}</span>}
                      </span>
                    ))}
                  </div>
                </div>
              );
            })}
          </div>
        )}

      </div>
    </section>
  );
}

function Main({ d, t }) {
  return (
    <main className="main">
      <CareerProfile d={d} />
      <Experience d={d} />
      <Projects d={d} />
      <Skills d={d} t={t} />
    </main>
  );
}

Object.assign(window, { Main, CareerProfile, Experience, ExperienceCard, Projects, Skills, SectionHead });
