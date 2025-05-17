import {
  Briefcase,
  Code,
  Code2,
  FileStack,
  Keyboard,
  User,
} from "lucide-react";

export const AboutSection = () => {
  return (
    <section id="about" className="py-24 px-4 relative">
      {" "}
      <div className="container mx-auto max-w-5xl">
        <h2 className="text-3xl md:text-4xl font-bold mb-12 text-center gradient-text">
          About Me
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
          <div className="space-y-6">
            <h3 className="text-2xl font-semibold">
              Passionate Software Developer & Student
            </h3>

            <p className="text-muted-foreground">
              Lorem ipsum, dolor sit amet consectetur adipisicing elit.
              Perspiciatis tempore sapiente tenetur non odit eius! Illo, hic.
              Facere perferendis aperiam quibusdam eligendi at corporis, dolorem
              omnis molestiae nobis, optio fuga!
            </p>

            <p className="text-muted-foreground">
              Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aperiam,
              error a, modi quisquam est voluptatibus laborum commodi doloribus
              dicta nobis veritatis tempora dolores rem fugit culpa consequuntur
              atque, porro similique.
            </p>

            <div className="flex flex-col sm:flex-row gap-4 pt-4 justify-center">
              <a href="#contact" className="special-button">
                {" "}
                Get In Touch
              </a>

              <a
                href=""
                className="relative group p-[2px] bg-gradient-to-r from-primary-gradient-one to-primary-gradient-two rounded-full hover:scale-105 active:scale-95 hover:shadow-[0_0_10px_rgba(139,92,246,0.5)] transition-all duration-300"
              >
                <div className="bg-background rounded-full px-6 py-2 hover:bg-background/90 transition-all duration-300">
                  <span className="bg-gradient-to-r from-primary-gradient-one to-primary-gradient-two bg-clip-text text-transparent">
                    {/* <span className="text-primary-gradient-one"> */}
                    Resume
                  </span>
                </div>
              </a>
            </div>
          </div>

          <div className="grid grid-cols-1 gap-6">
            {/* <div className="gradient-border p-6 card-hover">
              <div className="flex items-start gap-4">
                <div className="p-3 rounded-full bg-primary/10">
                  <Keyboard className="h-6 w-6 text-primary" />
                </div>
                <div className="text-left">
                  <h4 className="font-semibold text-lg">
                    {" "}
                    Full Stack Development
                  </h4>
                  <p className="text-muted-foreground">
                    Creating responsive websites and web applications with
                    modern frameworks.
                  </p>
                </div>
              </div>
            </div>
            <div className="gradient-border p-6 card-hover">
              <div className="flex items-start gap-4">
                <div className="p-3 rounded-full bg-primary/10">
                  <User className="h-6 w-6 text-primary" />
                </div>
                <div className="text-left">
                  <h4 className="font-semibold text-lg">UI/UX Design</h4>
                  <p className="text-muted-foreground">
                    Designing intuitive user interfaces and seamless user
                    experiences.
                  </p>
                </div>
              </div>
            </div>
            <div className="gradient-border p-6 card-hover">
              <div className="flex items-start gap-4">
                <div className="p-3 rounded-full bg-primary/10">
                  <Briefcase className="h-6 w-6 text-primary" />
                </div>

                <div className="text-left">
                  <h4 className="font-semibold text-lg">Project Management</h4>
                  <p className="text-muted-foreground">
                    Leading projects from conception to completion with agile
                    methodologies.
                  </p>
                </div>
              </div>
            </div> */}
            <img
              className="rounded-4xl card-hover"
              src="/public/images/Me.jpg"
              alt="Me"
            />
          </div>
        </div>
      </div>
    </section>
  );
};
