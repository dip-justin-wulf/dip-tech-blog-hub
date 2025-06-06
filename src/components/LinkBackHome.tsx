import Link from "next/link";

export const LinkBackHome: React.FC = () => (
  <Link href="/" passHref legacyBehavior>
    <a className="link-back-home">Back Home</a>
  </Link>
);
