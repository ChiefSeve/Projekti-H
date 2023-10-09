import textwrap

story = '''Olet lentäjä ammatiltaan. Ja sinut on juuri palkattu todella varakkaan henkilön yksityislentäjäksi. 
Haluat pitää työstäsi kiinni hinnalla millä hyvänsä, sillä se on korkea palkkaisin lentäjän työ, jota on tarjolla tällä 
hetkellä. '''

wrapper = textwrap.TextWrapper(width=80, break_long_words=False, replace_whitespace=False)
word_list = wrapper.wrap(text=story)


def get_story():
    return word_list
