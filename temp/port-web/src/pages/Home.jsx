import { Navbar } from "../components/Navbar";
import { ThemeToggle } from "../components/ThemeToggle";
import { HomeSection } from "../components/HomeSection";
import { AboutSection } from "../components/AboutSection";
import { SkillsSection } from "../components/SkillsSection";
import { ProjectsSection } from "../components/ProjectsSection";
import { ContactSection } from "../components/ContactSection";
import { LoadingScreen } from "../components/LoadingScreen";
import { Footer } from "../components/Footer";
import { useState } from "react";
import { cn } from "@/lib/utils";

export const Home = () => {
  const [isLoaded, setIsLoaded] = useState(false);
  return (
    <>
      {!isLoaded && <LoadingScreen onComplete={() => setIsLoaded(true)} />}{" "}
      {/* min-h-screen transition-opacity duration-700 ${
          isLoaded ? "opacity-100" : "opacity-0"
        } bg-black text-gray-100 */}
      {/* "min-h-screen bg-background text-foreground overflow-x-hidden transition-opacity duration-700" */}
      <div
        className={cn(
          "min-h-screen bg-background text-foreground overflow-x-hidden transition-opacity duration-700",
          isLoaded ? "opacity-100" : "opacity-0"
        )}
      >
        {/* Theme Toggle */}
        <ThemeToggle />
        {/* Background Effects */}
        {/* <StarBackground /> */}
        {/* Navbar */}
        <Navbar />
        {/* Main Content */}
        <main>
          <HomeSection />
          <AboutSection />
          <SkillsSection />
          <ProjectsSection />
          <ContactSection />
        </main>
        {/* Footer */}
        <Footer />
      </div>
    </>
  );
};
