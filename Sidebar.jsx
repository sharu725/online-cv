/* Sidebar.jsx — profile, live clock, contact, education, languages, interests */
const { useState, useEffect } = React;

function LiveClock({ timezone, location, zoneLabel }) {
  const [time, setTime] = useState("");
  useEffect(() => {
    const fmt = () =>
      new Date().toLocaleTimeString("en-US", {
        timeZone: timezone,
        hour: "numeric",
        minute: "2-digit",
        second: "2-digit",
      });
    setTime(fmt());
    const id = setInterval(() => setTime(fmt()), 1000);
    return () => clearInterval(id);
  }, [timezone]);
  return (
    <div className="clock-card">
      <div className="clock-loc"><i className="fas fa-map-pin"></i> {location}</div>
      <div className="clock-time">{time}</div>
      <div className="clock-zone">{zoneLabel} · local time</div>
    </div>
  );
}

function ContactList({ d }) {
  const L = d.links;
  return (
    <ul className="contact-list">
      <li><i className="fas fa-passport"></i>
        <a href="https://en.wikipedia.org/wiki/Birthright_citizenship_in_the_United_States" target="_blank" rel="noopener">{d.citizenship}</a></li>
      <li><i className="fas fa-globe-americas"></i>
        <a href={L.website} target="_blank" rel="noopener">{d.links.websiteLabel}</a></li>
      <li className="linkedin"><i className="fab fa-linkedin"></i>
        <a href={L.linkedin} target="_blank" rel="noopener">alexrudolph</a></li>
      <li className="github"><i className="fab fa-github"></i>
        <a href={L.github} target="_blank" rel="noopener">Xander-Rudolph</a></li>
      <li className="so"><i className="fab fa-stack-overflow"></i>
        <a href={L.stackoverflow} target="_blank" rel="noopener">xanderu</a></li>
      <li className="discord"><i className="fas fa-comments"></i>
        <a href={L.discord} target="_blank" rel="noopener">Discord</a></li>
      <li className="pdf"><i className="fas fa-file-pdf"></i>
        <a href="#" title="Opens your print dialog — an ink-saver, black-and-white layout for paper"
           onClick={(e) => { e.preventDefault(); window.printResume && window.printResume("ink"); }}>Printer-friendly PDF</a></li>
      <li className="pdf"><i className="fas fa-file-lines"></i>
        <a href="#" title="Opens your print dialog — a full-color PDF with every company, project & contact kept as a clickable link"
           onClick={(e) => { e.preventDefault(); window.printResume && window.printResume("full"); }}>Enhanced PDF</a></li>
    </ul>
  );
}

function Sidebar({ d }) {
  return (
    <aside className="sidebar">
      <div className="profile-block">
        <span className="avatar-wrap">
          <img className="avatar" src={d.avatar} alt={d.name} />
          {d.available && <span className="status-dot" title="Open to opportunities"></span>}
        </span>
        <h1 className="s-name">{d.name}</h1>
        <p className="s-tagline s-tagline2">{d.tagline}</p>
      </div>

      <div className="s-section">
        <LiveClock timezone={d.timezone} location={d.location} zoneLabel={d.zoneLabel} />
      </div>

      <div className="s-section">
        <ContactList d={d} />
      </div>

      <div className="s-section">
        <h2 className="s-title">Education</h2>
        <ul className="s-list">
          {d.education.map((e, i) => (
            <li key={i}>
              <p className="edu-degree">{e.degree}</p>
              <p className="edu-school">{e.school}</p>
              <p className="edu-time">{e.time}</p>
            </li>
          ))}
        </ul>
      </div>

      <div className="s-section">
        <h2 className="s-title">Languages</h2>
        <ul className="s-list">
          {d.languages.map((l, i) => (
            <li key={i} className="lang-row"><span>{l.idiom}</span><span>{l.level}</span></li>
          ))}
        </ul>
      </div>

      <div className="s-section">
        <h2 className="s-title">Interests</h2>
        <div className="chip-row">
          {d.interests.map((it, i) =>
            it.link ? (
              <a key={i} className="s-chip" href={it.link} target="_blank" rel="noopener">{it.item}</a>
            ) : (
              <span key={i} className="s-chip">{it.item}</span>
            )
          )}
        </div>
      </div>
    </aside>
  );
}

Object.assign(window, { Sidebar, LiveClock, ContactList });
