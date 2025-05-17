import { ArrowRight, ExternalLink, Github } from "lucide-react";

const projects = [
  {
    id: 1,
    title: "Music Link Converter",
    description: "Some shit i stole from jakob",
    image: "/projects/project1.png",
    tags: ["React", "TailwindCSS", "prolly an API"],
    demoUrl: "#",
    githubUrl: "#",
  },
  {
    id: 2,
    title: "Controller Button Visualizer",
    description: "Cant wait to get started on this",
    image: "/projects/project2.png",
    tags: ["Python", "CSS", "Idk"],
    demoUrl: "#",
    githubUrl: "#",
  },
  {
    id: 3,
    title: "Santa's Workshop Donation Project",
    description:
      "Full stack web application where people can donate toys to children in need",
    image: "/projects/project3.png",
    tags: ["Angular", "TypeScript", "Springboot", "Docker"],
    demoUrl: "#",
    githubUrl:
      "https://github.com/RIT-SWEN-261-04/team-project-2245-swen-261-04-5e-iwanttogohome",
  },
];

export const ProjectsSection = () => {
  return (
    <section id="projects" className="py-24 px-4 relative">
      <div className="container mx-auto max-w-5xl">
        <h2 className="text-3xl md:text-4xl font-bold mb-4 text-center gradient-text">
          Featured Projects
        </h2>

        <p className="text-center text-muted-foreground mb-12 max-w-2xl mx-auto">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime
          aperiam quis illum rem autem, corporis aut.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {projects.map((project, key) => (
            <div
              key={key}
              className="group bg-card rounded-lg overflow-hidden shadow-xs card-hover"
            >
              <div className="h-48 overflow-hidden">
                <img
                  src={project.image}
                  alt={project.title}
                  className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                />
              </div>

              <div className="p-6">
                <div className="flex flex-wrap gap-2 mb-4">
                  {project.tags.map((tag) => (
                    <span className="bg-primary/10 text-primary py-1 px-2 rounded-full text-xs hover:bg-primary/20 hover:shadow-[0_2_8px_rgba(139,92,246,0.2)] transition">
                      {tag}
                    </span>
                  ))}
                </div>

                <h3 className="text-xl font-semibold mb-1"> {project.title}</h3>
                <p className="text-muted-foreground text-sm mb-4">
                  {project.description}
                </p>
                <div className="flex justify-between items-center">
                  <div className="flex space-x-3">
                    <a
                      href={project.demoUrl}
                      target="_blank"
                      className="text-foreground/80 hover:text-primary transition-colors duration-300"
                    >
                      <ExternalLink size={20} />
                    </a>
                    <a
                      href={project.githubUrl}
                      target="_blank"
                      className="text-foreground/80 hover:text-primary transition-colors duration-300"
                    >
                      <Github size={20} />
                    </a>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="text-center mt-12">
          <a
            className="special-button w-fit flex items-center mx-auto gap-2"
            target="_blank"
            href="https://github.com/machadop1407"
          >
            Check My Github <ArrowRight size={16} />
          </a>
        </div>
      </div>
    </section>
  );
};
