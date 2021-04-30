def alignment_code_to_string(code, capitalize):
    if code == 'LG':
        if capitalize:
            return 'Lawful Good'
        return 'lawful good'
    elif code == 'NG':
        if capitalize:
            return 'Neutral Good'
        return 'neutral good'
    elif code == 'CG':
        if capitalize:
            return 'Chaotic Good'
        return 'chaotic good'
    elif code == 'LN':
        if capitalize:
            return 'Lawful Neutral'
        return 'lawful neutral'
    elif code == 'TN':
        if capitalize:
            return 'True Neutral'
        return 'true neutral'
    elif code == 'CN':
        if capitalize:
            return 'Chaotic Neutral'
        return 'chaotic neutral'
    elif code == 'LE':
        if capitalize:
            return 'Lawful Evil'
        return 'lawful evil'
    elif code == 'NE':
        if capitalize:
            return 'Neutral Evil'
        return 'neutral evil'
    elif code == 'CE':
        if capitalize:
            return 'Chaotic Evil'
        return 'chaotic evil'
