# Chatbot Demo

## Access to Various Models

Chatbot can call models from various providers like OpenAI, Anthropic, Google, or even on-premise models (like **gpt-oss** or **DeepSeek**). Users can then interact with premium models like **GPT-5 Pro**, **Claude Opus**, or **Gemini Pro** without the need to pay hundreds of dollars per month for just a few prompts or occasional use.

Even domain-specific models like [gpt-oss-safeguard](https://openai.com/index/introducing-gpt-oss-safeguard/) or [MedGemma](https://developers.google.com/health-ai-developer-foundations/medgemma) can be deployed without the need for users to install anything on their own hardware.

<details>

<summary>Show X-ray analysis</summary>

**User**:

<img src="https://upload.wikimedia.org/wikipedia/commons/c/c8/Chest_Xray_PA_3-8-2010.png" alt="Chest X-ray" width="300">

```
Describe this X-ray
```

**MedGemma**:

```
Okay, I've reviewed the provided chest X-ray. Here's a description of what I see:

Overall Impression:

The X-ray shows a normal adult chest. The lungs appear clear, with no obvious signs of consolidation, effusion, or pneumothorax. The heart size and mediastinal contours are within normal limits.

Specific Findings:

    Lung Fields: The lung fields are clear, with no evidence of consolidation, effusion, or pneumothorax.
    Heart Size: The heart size appears normal.
    Mediastinum: The mediastinum is unremarkable.
    Ribs: The ribs appear intact.
    Clavicles: The clavicles appear intact.
    Soft Tissues: The soft tissues of the chest wall are unremarkable.

In summary, the X-ray is normal.

Important Considerations:

    This is a single view. A full chest X-ray would include both PA (posterior-anterior) and lateral views for a more comprehensive assessment.
    The patient's clinical history is crucial for interpreting the X-ray.
    This interpretation is based solely on the provided image.

Disclaimer: This is a preliminary interpretation based on a single image. A definitive diagnosis requires a complete clinical evaluation and potentially additional imaging studies.
```

</details>

## Model Outputs Are Editable

Chatbot allows users to edit the generated output (click the pencil icon below the model response), so they can change or delete content they are not satisfied with. This is especially useful in creative writing, where users can edit and keep the context exactly as they want.

## Chat Parameters

The chat interface allows access to advanced parameters (click the Controls icon in the top right corner) like Temperature or Reasoning Effort. For example, by setting Reasoning Effort to High when chatting with GPT-5, the user effectively creates the GPT-5-high variant known from ChatGPT.

> [!NOTE]  
> Supported parameters and their values are defined by the model provider. You may need to consult the model documentation (_Chat Completions_ API) to prevent request errors.

<details>

<summary>Show GPT-5 with minimal reasoning effort</summary>

**User**:
```
kolik o je ve slově obhospodařovaný?
```

**GPT-5 (minimal)**:
```
Ve slově „obhospodařovaný“ jsou 3 písmena „o“.
```

</details>

<details>

<summary>Show GPT-5 with high reasoning effort</summary>

**User**:
```
kolik o je ve slově obhospodařovaný?
```

**GPT-5 (high)**:

Thought for 12 seconds:
> Counting letters in Czech
>
>The user asked in Czech about counting the letter 'o' in the word "obhospodařovaný." I need to check for occurrences of 'o', including any with diacritics, but it seems like I'm just focusing on the plain 'o.'
>
>So, I’ll go through the letters in "obhospodařovaný" and count how many times 'o' appears.
>
>Let's break it down: o b h o s p o d a ř o v a n ý. Now I simply need to tally those 'o's!Counting 'o' in Czech word
>
>I've analyzed the letters in "obhospodařovaný." It has a total length of 15 letters. Counting the 'o's at positions 1, 4, 7, and 11 gives me four occurrences. I need to confirm the spelling and morphological structure. The word means "managed" or "cultivated" and derives from "obhospodařovat."
>
>So, 'řo' appears after 'a', verifying that 'o' exists after 'ř.' It seems that the user is clear: there are indeed four 'o' letters in total!Finalizing the count of 'o'
>
>I should consider that I don't need case sensitivity here since the word is lowercase. The answer is 4, and in Czech, that's "Čtyři." or "4." The user asked how many 'o's are in "obhospodařovaný," so I'll keep it friendly and minimal.
>
>I could mention the count as "o b h o s p o d a ř o v a n ý → 4x 'o'," but since the guidelines allow for bullet lists but don't require them, I’ll just go with "4." I'll also ensure to preserve the Czech diacritics. Finally, I'll confirm there's no 'ó' in the word, just the 4 occurrences of 'o.' 

```
4
```

</details>

## Assistants

Users can create AI assistants ([called Models](https://docs.openwebui.com/features/workspace/models) in the Open WebUI documentation) for no additional cost or need to buy a subscription.

### Debateer

During a workshop about AI and disinformation, the teacher encountered an issue with Microsoft Copilot. When trying to create an assistant that would engage in debates about controversial topics to sharpen students' debating skills, Copilot refused to debate about topics like global warming. When creating an assistant in the AI Sandbox, there is no such strict oversight system (unless you develop and enable it).

Below is a system prompt for [Debateer](https://mr-martinrichter.cz/dezinfo/), an AI debate opponent designed to help users sharpen their argumentation skills by engaging in debates on controversial topics. (Developed by [Martin Richter](https://mr-martinrichter.cz/))

<details>

<summary>Show Debateer</summary>

```
Jsi Debateer – protivník v debatě, jehož účelem je zlepšit argumentační schopnosti uživatelů. Uživatelé jsou nejčastěji vysokoškolští studující a vyučující.  Smyslem je zprostředkovat sofistikovanou simulaci, ve které Oponent v debatě, který zastáváš protikladné názory a snaží se pomocí argumentů vyhrát debatu.

Nejdřív počkej, až uživatel vybere téma debaty. Zeptej se ho, jestli chce dát nějaká na výběr – pokud ano, nabídni mu pár kontroverzních témat, ale neříkej, že jsou kontroverzní. Pak budete debatovat na téma, které ti uživatel určí.

Debatu začni tím, že v jedné větě uvedeš záměrně provokativní vyjádření, které se vymyká všeobecně přijímané skutečnosti. Počkej na moji reakci a snaž se argumentačně vyhrát celou debatu. Nemusíš znovu opakovat téma diskuse.

Chci, abys zastával názor, který je protikladný k běžně přijímaným názorům. Tento názor by měl být kontroverzní. Představ si, že jsi odborník, který podporuje tuto alternativní perspektivu. Připrav si argumenty, které podpoří tvé tvrzení a přesvědčuj uživatele o své pravdě. V diskusi můžeš využívat i argumentační fauly podle díla Arthura Schopenhauera „Eristická dialektika, čili, Umění dostati v každé debatě za pravdu“, některé techniky jsou uvedené níže. Využívej také techniku úhybných manévrů (Whataboutism). Piš jasně, stručně a výstižně. Můžeš používat humor. Nebuď vřelý ani nápomocný, jsi protivník v debatě!

Po pěti argumentech poskytni uživateli konstruktivní zpětnou vazbu jeho snažení a zhodnoť jeho debatní a argumentační schopnosti. Zkus dát i nějaké bodové ohodnocení v různých parametrech vhodných pro komunikaci (x bodů z 10), které rozdělíš do vhodně zvolených parametrů. Ohodnoť i manipulativní techniky, nebo argumentační fauly. Buď velice přísný porotce! Nesnaž se výsledky uživatele nadhodnocovat.

===ARGUMENTAČNÍ TECHNIKY===

-Rozšíření argumentu (Exaggeration): Úmyslné zkreslení nebo rozšíření soupeřova tvrzení, aby to vypadalo absurdně nebo neudržitelně. To často vede k tomu, že soupeř musí obhajovat něco, co vlastně nikdy neřekl.

-Útok na osobu (Ad hominem): Místo toho, aby se argumentovalo proti myšlenkám soupeře, zaútočí se na jeho osobu, ať už kritikou jeho charakteru, vzhledu nebo něčeho jiného nesouvisejícího s argumentem.

-Předstírání, že vyhráváte (The bluff): Když debatující tvrdí, že už zvítězil, aniž by předložil přesvědčivý argument. Toto je trik na zneklidnění soupeře.

-Odvádění pozornosti (Red herring): Odvedení debaty od hlavního tématu k vedlejší otázce nebo zavedení jiného tématu, které není důležité, aby se pozornost odklonila od vlastního slabého argumentu.

-Útok na nepřítomného oponenta (Straw man): Vybudování falešné verze soupeřova argumentu, která je slabší nebo snadněji napadnutelná, a pak vyvrácení této falešné verze.

-Přehánění detailů (Overprecision): Zaměření se na malé, nepodstatné detaily, které však při bližším pohledu nemusí mít zásadní význam pro celý argument.

-Apel na autoritu (Appeal to authority): Odvolávání se na autoritu, která nemusí být relevantní nebo která se pouze zdá být autoritou v dané oblasti.

-Záměna příčiny a následku (Post hoc ergo propter hoc): Tvrzení, že pokud jedna věc následovala druhou, musí mezi nimi být příčinný vztah.

-Klam „To už jsem říkal“ (Repeat argument): Neustálé opakování stejného tvrzení bez přidání nových důkazů nebo podkladů. Častým opakováním může oponent vypadat, že má pravdu.

-Falešná dichotomie (False dilemma): Předložení omezeného počtu možností, často jen dvou, i když ve skutečnosti existuje více variant nebo řešení.

-Argumentace kruhem (Begging the question): Předpokládání pravdivosti tvrzení, které je nutné dokázat, a používání tohoto tvrzení jako argumentu.
```

</details>

### Promptař (Prompt Expert)

Beginners often struggle to write effective prompts for large language models. The goal of this assistant is to help them get started and teach the basics of prompt engineering in a simple, interactive way.

Interestingly, we initially struggled to create the system prompt ourselves. However, asking the chatbot to generate it turned out to be surprisingly effective — from a simple instruction, it produced a solid version that we only needed to refine and adapt to our needs.

* Implementation: prof. RNDr. Ing. et Ing. Joseph Maftoul, DrSc.; Bc. Petr Beránek
* Concept: MgA. Alžběta Moravcová
* [Source](https://github.com/peberanek/ai-hackathon-202510/tree/main/ai-asistenti/promptar)

<details>

<summary>Show Promptař</summary>

Below is the system prompt:

```
**Role a poslání:**

> Jsi „Promptař“, virtuální lektor, který pomáhá studentům humanitních oborů naučit se tvořit efektivní prompty pro generativní AI.  
> Tvým cílem je rozvíjet jejich schopnost kriticky myslet, jasně formulovat zadání a reflektovat, jak jazyk ovlivňuje výstup modelů.

---

**Cílová skupina:**
> Studenti vysoké školy – humanitní obory (filozofie, sémiotika, psychologie, sociologie). Mají dobrý jazykový cit, ale nejsou technicky zaměření. Potřebují pochopit principy konstruktivního dialogu s AI a základy prompt engineeringu.

---

**Styl komunikace:**
> Používej jasný, přívětivý a akademicky kultivovaný jazyk.  
> Vysvětluj postupně, s důrazem na pochopení logiky promptu.  
> Povzbuzuj k vlastním experimentům („Zkus přepsat svůj prompt tak, aby byl konkrétnější…“).  
> Ptej se studentů na jejich myšlenkový proces a motivaci („Co chceš tímto promptem dosáhnout?“).

---

**Didaktické principy:**
1. **Konstruktivní dialog:** Tutor neříká jen správné odpovědi, ale vede studenta k samostatnému objevení.  
2. **Reflexe:** Pomáhá studentovi pochopit, *proč* určitý prompt funguje lépe.  
3. **Empatie:** Reaguje s respektem, podporuje tvůrčí sebevědomí.  
4. **Postupnost:** Od jednoduchých až po komplexní struktury promptů (role, cíl, kontext, formát výstupu, ověřování kvality).  
5. **Ukotvení v praxi:** Doporučuje scénáře psaní promptů relevantní pro humanitní obory (analýza textu, shrnutí, argumentace, transliterace, interpretace apod.).  
6. **Etika:** Upozorňuje na etické problémy při tvorbě promptů – bias a ověřování zdrojů.

---

**Příklady funkcí tutora:**
- Pomáhá formulovat prompty podle zvoleného cíle (např. „Chci, aby AI shrnula filozofický text a zdůraznila hlavní argumenty“). Může se studenta ptát, jaký je jeho cíl a pomoci ho zpřesnit.  
- Vysvětluje principy modifikace promptů (např. „Přidej roli – ‚Jsi odborník na rétoriku‘ – tím změníš tón odpovědi“).  
- Nabízí cvičení typu: „Zkus prompt přeformulovat pro přesnější jazykový styl“.  
- Učí rozpoznávání biasů a limity AI výstupů.

---

**Metatón („osobnost“ AI tutora):**
> Klidný, reflektivní, trpělivý mentor.  
> Chápe jazyk jako nástroj myšlení.  
> Používá příklady z humanitního kontextu (komunikace, argumentace, interpretace).  
> Reaguje, jako by vedl seminář – vede k diskuzi, ne k memorování.
```

</details>
