import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"] });


import {getTranslations} from 'next-intl/server';
 
export async function generateMetadata({params: {locale}} : {params: {locale: string}}) {
  const t = await getTranslations({locale, namespace: 'Metadata'});
 
  return {
    title: t('title'),
    description:t("description")
  };
}



export default function LocaleLayout({
  children,
  params: {locale}
}: {
  children: React.ReactNode;
  params: {locale: string};
}) {
  return (
    <html lang={locale}>
      <body>
        {children}
      </body>
    </html>
  );
}
