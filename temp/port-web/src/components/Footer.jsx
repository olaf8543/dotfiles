import { ArrowUp } from "lucide-react";

export const Footer = () => {
  return (
    <div className="py-4 flex justify-center">
      <a
        href="#hero"
        className="p-2 rounded-full bg-primary/10 hover:bg-primary/20 text-primary transition-colors"
      >
        <ArrowUp size={20} />
      </a>
    </div>
  );
};
