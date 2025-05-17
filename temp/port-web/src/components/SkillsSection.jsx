const skills = [
  "HTML/CSS",
  "TypeScript",
  "React",
  "TailwindCSS",
  "Angular",
  "Next.js",
  "C Language",
  "Java",
  "Python",
  "Node.js",
  "Git",
  "RESTful APIs",
  "CI/CD",
  "Agile Methodologies",
  "Docker",
];

export const SkillsSection = () => {
  return (
    <section id="skills" className="py-24 px-4 relative bg-secondary/30">
      <div className="container mx-auto max-w-5xl">
        <h2 className="text-3xl md:text-4xl font-bold mb-12 text-center gradient-text">
          My Skills
        </h2>

        <p className="flex flex-wrap justify-center gap-4 mb-12 text-muted-foreground">
          Here are some tools and technologies I am experienced with!
        </p>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {skills.map((skill) => (
            <div className="bg-card p-6 rounded-lg shadow-xs card-hover">
              <div className="text-left mb-4">
                <h3 className="font-semibold text-lg"> {skill}</h3>
              </div>
              {/* Bar below each skill */}
              <div className="w-full h-2 bg-gradient-to-r from-primary-gradient-one to-primary-gradient-two origin-left rounded-full overflow-hidden" />
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
