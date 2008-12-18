== LaTeX und Neo ==
Der typische (La)TeX-Nutzer profitiert in vielfacher Weise vom NEO-Tastaturlayout: Neben den besseren Anordnung der Buchstaben sind beispielsweise auch die häufiger benötigten Sonderzeichen wie \{}[]|$ viel besser erreichbar.

Die hier vorgestellten Pakete und Programme zielen darauf ab, darüber hinaus auch die Unicode-Zeichen auf der NEO-Tastatur direkt in LaTeX eingeben zu können.

=== XeTeX ===
XeTeX ist eine moderne Alternative zu e-TeX, die neben nativer Unicode-Unterstützung auch die einfache Nutzung moderner Schriftformate (TrueType, OpenType) und ihrer Vorteile (bspw. Ligaturen und Variationen in OpenType-Fonts) ermöglicht. In diesem Ordner befindet sich ein einfaches Beispiel, das genau diese Features demonstriert.
Leider jedoch unterstützt XeTeX derzeitig noch nicht die typographischen Feinheiten des Microtype-Paketes (optischer Randausgleich etc.).

=== XeTeX-unicode-math ===
Mit XeTeX können Unicode-Zeichen auch im Mathematik-Modus gesetzt werden. Die Unterstützung hierfür ist zwar bereits weit fortgeschritten, wird aber noch als experimentell angesehen und ist deshalb in einem separaten Paket unicode-math ausgelagert. In diesem Ordner befindet sich neben einer Installationsanleitung auch ein Beispiel, das grundliegende Features demonstriert.

=== Standard-LaTeX ===
In diesem Ordner befindet sich das Paket uniinput. Es setzt auf dem Standard-Paket utf8 (via inputenc) auf und ergänzt dieses um mehrere auf der NEO-Tastatur vorkommende Zeichen (insbesondere aus der Mathematik). Es wurde von NEO-Nutzern geschrieben und hat den Vorteil, mit dem »normalen« pdfLaTeX benutzt werden zu können.

