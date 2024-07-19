<#
.SYNOPSIS
    This script is used to notify users with a 'full' recycle bin.

.DESCRIPTION
    Script to notify users of a overly full recycle bin.
    Displays a windows toast notification to the user.

.NOTES
    File Name      : MDM-Bin-Size-Detect.ps1
    Author         : Tobias Putman-Barth
#>


begin{

    # Image header format base 64
    $Picture_Base64 = 'iVBORw0KGgoAAAANSUhEUgAAAWwAAAC0CAIAAAA/54EYAAAACXBIWXMAAAsTAAALEwEAmpwYAABWw0lEQVR4nO2dd3wUxdvAn9ly/dJ7I4UQuhQpNmz0ZgEVsYAKiIBiQRHBjmIHCwrSQURA/EnvRYqQQg+kkd6TS66XrfP+sclxuQQQQgB99/sJfJLd2Zln53afm3nmeZ5BGGOQkZGRuVaImy2AjIzMvxtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINAtZicjIyDQLWYnIyMg0C1mJyMjINIsWVyJsUWHpzJnp7dtn9ulT88svmOdbukUZGZkbCcIYt1ztroyM7L59nWVlJAAACAAho0fHLluGFIqWa1RGRuZG0oIjEcxxFx56mCkrowAhQAgQBVD166/lsz9puUZlZGRuMN5KRHQ6uaoq0eFoTqWCyVS7dq1gNhMadcMzCAFQwcGOkydNmzZB8wZBfE0tX13dnBpkZGSaTwMlYv3rr3Ndu55r1y69Q4eSt97iysuvrdLyTz7JGjUq78nRUV9+Sep0ABgAA4AI2KdXb03nTpn33JPz0EPO8+f/eZ2Y49y/2w4dyhk8+Fy7tunt2uU+/LBgNF6bnDIyMs2ngU3kXNt29qxMAgAD8ADqwMCkffvUnTvnPjrCVVgY8+UX+gceuGKNtiNHsvsPwA47BvC57z5Hahprt6H6s+rWrTHLuoqKAMDnjjsT9+wmNJrLVyg6HJVff129enXkrFmBTz9dPvuTondnYQAKAAB4gFYffhT+3rvXdv8yMjLNpMFIhKuukiygCCB8zBgqOCR7wADHyVPWvXvtJ45n9e2bN3o0W1x8ufowLn1rOu+wAyAEyHzgAGe3+fXt12bbttiFPytCQpwXLjBFRQQgAsB89G/Lzl2Xl8+yfcf5Hj2K33vPmZVlWv977a+/Fr87K2jkSL8ePd03YE8+1owekJGRaRYNlIiqTZKAUNgb0+JXr45dvqx9Wiqi6OLXXiV0OhIAYWxYsybzzruYvLxLVSfa7UxBgbtSBKCOT2i9aaPvoEHBE8bHrliBSApdPAmWXTsvI1zV/PlZgwc5z58nAUgAvrq68KVJEW++mbB+feyqla03btR26QoA+vuvPD6SkZFpIRpMZ3iDgS0u1nTt6j5i2rgx++GHCQAEde++ADhgyJCETZsQ0cTKjmCxnEtqy1aUS+UFwAFDhrbeslk6K9rtZyKjeLPJfTZk7NjYZcualIwtKkpv205wOoj6pkXAiuCQTgX57hkQbzCwBYWa7l0ByV5zMjI3hwbvHhUU5KlBAEDbqxetUnldYNmzlyspkf7ka2pq1693z3EIjYb09cUehW1/H3FlZkp/Ghb+zJlNnrWpb7vN/bvt0CHLrl0gitKfpj//5D00CABgAG337p42FCooSHN7d1mDyMjcRK7w+tFhYaFvveW9EisIos0GAIBxwTPPZj/+eFafPnxVFQAgigp45mlACAAwYNo/gDcas++7r+SNN/KeGFU87Q2SpkmNFgPGgGm93m/YMKlK49p1GX36ZA4YYN6+QzrClZZ5tokBUzp95OefX4eblpGRuX5c+Tvc//HHEYC0Riv9TyiVhF4PAJjjnBkZJICroMCVnSOVD3/nHU3bdixg/0dHBL88GQOwlZVl33xjWLcWY0zo9dE//EAHBXMAUV99pUxIkK6q+vFHaR3YkZYmHVHERNeLgKV/yshIdedO1+3WZWRkrgfUFUso4+P19/SxHDpIIAQYiwCKVq3osDAAQAqFpsttzoJ8AoAtKcY8jygKEIr8ZLbP4cPaLl0KJk0iAAAQWV8bV1tbveCnVot+Nu/c5T9ypHRQMJtBFBAAQRD6B+uspNo77iARIWKRIEhpjhMy9ZXrfv8yMjLN5MojEUKtjl22lFSpkVIR/u67yogIRWwsomkAsKemWv/+mwBAAAXjxjlPn5Yu8Xvkkeivv675ZTVnszV2SrWmpFDBwa1++pEKCJCOFL8y1XL0KAEIRLF89mzRbgcAOjKS1Gr9hw7ze2g4D9i3T5/gl166fjcuIyNzffhHJkllQoKud2/e5ar59dfQqVNjFvwkHUckSYeEgjTXiI5Wxsd7XhW35td2O3YowsIlC4j04z98eMcTJ3R33eVZ0veh4QRJYsBIoSDUGsmkQoeEtN6+jQzwN+/eTQCEvvnm9bljGRmZ68o/XdcIeXkKAnDl5pa++y5vMEgHNd26hU6eVGfLyMzMGTLEvHkzk5/PV1VxFRVCTQ1z4YLIcxhAFRdPanUYQDCahNpatrCQr6riKsqd589XfP550UuTRJbFAIRS1WrJ4rr1F4RqVqysWrlSsNmUISG6u+9uoS6QkZFpDle2iUj4Dh2qio1jCvJFlnWeOaPu0EGwWm2HDpW8+x4C8H/kEefZdOvRo9bhwymNllCpMMai1crzHAGgadc+dvkye3Jy6TvvWA4dtPTtW1dGFEWbTSrje/8DXGmJIzs7f/ToqC+/VCYkIJK0p6RKPvhBE14k/fxash9kZGSukavIJ1L8xhvl33xDAqICAsjAQMFs4qqqMIA6Lj7mx/nmnTurFy7ETqdndZJTGenvDwCEQsGbTJhhoFH0rjIhIXzGDNFqK57+lsiyJK2gw8MRTbPFRZhlgaQ6pKer2iZdnzuWkZG5rlyFEuHKy8+1bcdbzACAAZDkuA4I0QqRY7DH1MizRuzxP/L4Hxr+LgIQJIUwxqKI6ytAACKA/8BBrbdvu8r7kpGRuUH80+kMADjPnRMFvk5xAAAABgyAJQ0CAAIAAiApilRrkEpFKJVIQSOKApJCNA0YY54DQcQ8j1lWZBjsdAoOhygKdZcLPPLQTfXNYr7GIJhM8nRGRubW5CqUSM3SZazdTgFgwNJIhFSqqMBAKiCAjopSt2urvq2LIi5WOoIUCkTTiKIQSSKlEjCuc2NlGCwImOcxx2GW5Q0GvtbIZGc7Tp50nT/HVVbxNQa+uloADPUKxZKayuTmarp3b6k+kLkh1K5ZU710KR0QEP7ee+oOHW62OC2F6HJVfPa55dAhXbeu4bNmkb6+N1uiZmE7etS0cZPz9CnRZkO0ggoKUrZJ1Pbs6Td8uLvMVUxnXDk5eY89xtfUKKJjtD176O6+R9OlCxUcROr1QBAAUDVvnvauu7Q9enhdWLt2beW33xJqdeRHH3kt7gKAadMmRBC+Q4cCAOY4wWJh8vPtR49a9+93ZWWx5eUBTzwRPXcu0TCER+bfhWXv3qy+faWFPE1EZLvTp6igoJstVItQPHVq6XffEQAiQOgzz8atWF4/cP+XgV2uvKefqd3wuxTMRgEI9afogICuNTUeRa8SrqamyeNVP/50FCAVIduxY57HRYY5Ex1zBOAIQHa//l5XVS9enAyQAmA9fLhxnYLVylVVXa2EMrcgRVOnHgNIA5QGkApgP378ZkvUUqR36JgCkAYoFeBkQCBvsdxsia6RoslTjgGkAqQiouKrr5miosoffkilqDRApwICPEteXfyrPSUlZ/DgjNtvZwoKvE4pWyeoQkN1vXur2rXzPI4Uijb79kZPmxb7/vvx69d5XeXTt686Okbdti0dHOx1ynb48PmePfOfHcMWFl6VkDK3INL8BQMWAQiKlhbs/pMooqJEAAxYAFAlJBBqdeMyXFVV7bp1tWvXuq4mQ+iNRLBaatetIwEwgG+/fqFvvK6Ijg6ZPFkVHS00Wl29CpsIAJS8Mc2YnEwCcMXFythYz1M+/fq1++svLAiC0cgWFop2G1dZxdfUChYzAqCDgwEhw9KlAIjy9SWDg+jgYEKnI/384tb8qoyPp8PDvdqy7j9gycjAGRn6X1aHzXznGjpC5tYhcMwYy65d5gMHCJUq/K3pyri4my1RSxH97Txu9GimsFAVHBw9/wdENfGKWXbsyBkzBgBiZs6MmD37hst4ZVznznPV1dLyqP6ee9zH1R07iQC0X4PvgKtTItHfzlOvXOlz//26e+4R7Xa+xsDX1LoysxwnTjjT07niYr6mRrBYRKcTYxE3XOv1pG4VhiAJtYr086cCAxQxrdS3ddZ0765KSKCCg6mgoPB3Z1HBQa6cCwFjxlx1H8jcYiCFIn79er6mBtE06eNzs8VpQVRJSe2Sk3mjkfLxQUplk2Xsx5KlKYAUg3YLwuTkYMCSLYfQ69zH49atBVH0svJcnRLRdOsWyHG2v//OGTzYlZ7OG02izSrWu42Ax/+NVmq9wAAAoiDY7YLdzpSW2M6cgS2bEQCBCNLXlw4L1fTs6TtwYOiUyYqoyKsSUuaWhQoMvNki3AgQRTWenrsRbDbzjh2S5RWaSg94K8AbjRgAAAFgT5XR5PpGAyUi2GxCba07t1gjkO3Y0Zwnn4SLOsJTX1wEN/nrpSr1yL0ozZp5k5EzGe2ZmVUrV9Ik1Wb/PkV0dIMrKBJJC8YYU35+hE7XuNr/AJhl2dJSqWtEllXExDQ5wb5sFVh0OiXHHMwyIsOIdgcdHkEF1sVPY57HDHPRc8flEp1OZXw8odXWFeA4zLJ1BVwu0eEgFApFXJx0ypWTwxYVCRYLHRamiIryisCUEF0u4HnMcSLLYpdLdLlAEFRt2wJBAAbR6Why+yFCrQaCkGTzOoVUKkSSnkfYwkKuvJwtKwNRpENDqeBgRatWXn2FBQG7XFgQMMtihhVdTtHlUrVuLQ0W2KIitqiIq6ggdDpFVJQqMdFrEMHk53PlFVx5GYgiGRBABQZS/v50WDhS1u/lKHV1Xf0MZlnB4aB8fenI+q9AUeQMBjYvr2Tam678PAIQAMYMI8Ws10GS0lsq9VLjbpHu/R92ixdMfj5fUcmWlSEC0RERdFioolWsVxmplwBA+r/uoMt1Uch6CRs0jT0+wqp580o+/pjWX3K0iTlOtNsBoUuOMC4LAoQBPDULIinMMILV6t0QYIKiCb0OREzqdOAxsSRUSr6qGgsCAAiAY+bMCZ406VqkueXJe+xx47atBCCR57Tduydu23a1HndsSUnmHXcKNitBkFgQMMfxjCt+0aLA556TCtT++mvByy8TIkYEgXleUjRtjx7V9uolFTAsWFA0c2ZdAY7jGFfAkCEJf/zhOH68cOJEaZEFABAAoVbr778/5vvvlPEJnjJcGDzEeuwoAoQQiCwnsowiLLzD+XOEVis6HJm9enOGakTUP/0YCy4nQVFJhw6pkpKKpkypXr2aIqn6V1oUna7Ebdu0vXtLxe1Hj5a8+6796FHe4ZC++hAARdHKuLjwme8EekyEbYcO5Tz8MBJFRJBYEESWQSTdMTuL9NEXT5tWs3KV6LBLzyVBEG0PH9becYf7wpJZsxypabzTowkAQqenIiNivvjCd/hwABAslsxevdmKcoIgsShgjucZV9iUKdFz50r1OE6eyOpzL2+zYQCy/v0hNBp3uk8RsM89fRL+2AAAOYMG246nkfTF3WYx4xIFoc2OHdpeveq6hVbUzYZEQWCYNh7d4oXt8OHSd9+1p6S4e4kAoDVaTe9ekR9/rLvzzga99OijBIDovKg4CK1W0sieEnrSYCTCVxt03brHrVjepCgAAAhdXttdDoQQTQNCmGHqjhCEaLfnjnzMnpbqqZZEwKRW1/rP/2l79UIICTabe3CEVCrjmjWFL78sfX0JDVXmf4myd98z/L6eAOABKD+/2GXLrsFnF5EkFRSIFDSblye9ISI0GB0SKhUdFAQOJ1NSlyUXAXgOX5FKTQUFgc3OlpVKlxNqtfNsesY993BOp4IgQUELjAsARKfTuG2b89SpdqmpdESEuwbSz5cKCuLLKzibFdVtYlY/1EWIjox0pJ+9OB1GhKpDe1KtJmgFANBBwcq4OFxrdBUWSNeqk5LcY4Sq778veu01URAIgICBg3wGDsSAzZu3mPfuceZk544da09OiZn/g3Q7iKapoCAkisyFXMlbktbTmGNzH3nEsHu3kqLdcRuiKLq/5w3LlheMHyc1ETh8uE///lgUzdu2m3dsF2xWJivLduyYpESAIKjAQMxzTG4exmLjrgZAhEaj9PUVbXbBbHb3ABDExbFYfcfT4eHA80x1tfuTUMbG0f5+0r1TQcHKuDihtIwpK5UuUnfseCn7S8UXX5bMeFsURQSg69rV54EHAMCyd5/91Enzvn3WAwdaffdd8OTJF+Vx/1wU3EPIJn1ePNd7S2fOuvDoiJZbec4dNap64c+eRy6MGJlS5z5Q95MKkKZUmnfswBjXrFyVN2aM6GLc5S3795/Q+6TWX5IMUDl3bssJfLOoXbcuVVqiB0gjKcuevddelyCILJszbFgygNRjhqXLLp4VRcwLgsWSnpSUApAGkAZgS05uWIDna2vPxsWnAqQAXBj+0PmuXdP0+vJPP3VmZrry8irmzj2u0UofyjGA4mlvegmAed5y4EAaRUlOImdiWgk2m/t82SefSLKlAJzr2KnxHRj//DMFIEXyM+J56aBpy9YUAEmkqvnzPcuXvD1DupdkgJq1az3vVOS4guefTwZIBTgdGpb/zLPJABVffunKyyt9971UgpAktB46hDFmS0pO6vVS0/ljxng2kffUUykAyQBlH3zQoKs5rvi1191dXfTqaxc7kud5s5k3m8vnzHEXKJkxgzdbpOO82ezZLa7c3JMBAakAkkgNPhSMMcalM2clAyQDlM54p3GnSdT+/ru7lwqnTBHre0/k+fyxz7lPSa8bxljkON5s5s0WTyHL58xxC+kpoZtGdp1LGkSahWizFY4fX/3bb+WffopZTtJeeU+Ortnwe8N87hhIMmHNGp8BA2p/XVM4aVLVihXO9LPSWdvhwxeGDReslmucTf1LcJw8VfDCC1Affxjz7bfulJHXAkEgmvZy3rkIQkAShF5PBV3CEIgQkCTp708FBWEAApB5z27nufPt9uwNmzFDlZSkjIsLffXVyNkf180FAEwbN2KW9RQASFLTpQul92nSQhYyaZIyMEhaC2Dy8phGbkG1v/0mXRj61ptAkgCAeb7kzTdB8n9t1y544kTP8hEffahqFSuNbio++qhu5IsQkASiKGmDAQSINxiqV62M/WZu6LRpyri48Pffo/0DOGl4KwgAYNq4kbVaCUAYwCvqIuj55zGACNDANkEQiKI0Xbo03ZEkSfr4kD4+ntsVEGo16aOXjpM+Pm5TFAAo4+MDnhwtAgAgEcC8fbtXheatWwGAUqqCJjWd8Q+zXNmMOt8I2s8/4sMP3dMIRJLR385ThIVJfxa//Io0eUEURfr4kD560kNIUqNxC+kp4cW7aLL5i3LwPF/v38pcuFDzyy+2I0fc230LVqvt8KGaX1a5szSzRUUXZysecFXVtb+sJilSMBoFswkACidMMPy2xnNqhAEDoPgVK/weeQQAqufPlwbA0pbAjuPHLwx/SLBZ/9sahK+uzh05krdaESABIOzFicGTr4PFh7zSXqVXds2uL8A7HMFTJmt6NghuCHzqKdrHV1IEgsEgSJsBeIBF4VJNkH5+urvvFqUX22G37d/veVZ0OGwHDyEAZWiYO6LCfvSoMzNDyjXj99DDXmsciKaVCQnS9MSVmeXtGFn/NSkKvCI4JHDcC/X3hwKffTZ4xMigkSPp0FAA4Cor604B1KxY6bnLvaJVK2379urERKlkgzttyiDapADevzcibNo0WqvFgAmAmoU/i1aL+5Q9Odlx9gwA+D/+uCIqqsnLrX8dcORkS8tA+gcecGcjlSB9fNTt20u95MjJdpw61eAuPATDVxpYXHKJF7OsYLOZNm7ky8tDp02z/f13yRvTrCeOI4B2hw7q7r4HAKz792c/9BAA6Lt2C3//PZ9+/Sq//Ir09w8cO4YOD/c0jyvj4zpeyOHNZswwVHBQ8WuvVS5eTAK4Z4HSNDV2wU8BTz0lHWm9ZTOTny/Y7ep27Z3nzuUMGcIZa72HLf8tMM/nPv6EMy+XBCQA9u1zb/S38262UF5gAiBgxAivo0itJrRasJgBLjVtvlylIVOnGjdvkt6o6p8XBTzzjPs707xtG1NWigGCxr3gDmYzbdokYkwCAsBNDrKUMTF1NiCB5w0GSGoiGY30apF6fd3fBBH1zdeeBTS3315/y8h2PC37wQcjP52j6dqF9PNTJiR0OHsWcxw05Ut2vVDEttLdeadx924SwFVeZk87ob//PulU5TdzBUEgAEJeeflSl5v+9z/3Mq2uV8/GBdSdOpn27QNAGLD1wIHGcW3/kEt2AVdRUT5njis93ZaaqkhoLdTWBIx+ksnNdZlN1T/+JCkRw4IFIoDK1y/g6afY4mLjhg1Vy5b63H238/y5yI8/9vp06chIabmrbOas8nnzPDUIABYBWn31VfCLLzK5uYRaTUdEkP7+Gn9/AGALC3MGDWYrKz01iABY37Ub5jmxqYHPv5TiKS+bD+wnAYmA1TGt4n9bcylr2U0EIQI1HtOKYpMrtf8QfZ971IltHFmZCMCeksLm5ytbt5ZOGRYtwgAkIvxHP+ku7zxzts4PClDFnE9rli31/LZEBOHMqNuXXgTga2ov1a4qqc1lpPIdONDnjjvNR/+mABOArMeOZT1wvyIi0nfYsIDRT2q7d29ybH99CZ02zbxnL2ARAxh+XigpEcFsth7YDwDabt01Htu/eeE8n+F+YTxN3W48PSecJ09es5CXns6QpGXnLsvhw5hh8seOFRyOgFGjYhYu0LVONKxZU/vLL4ZFi4w7d+o7dmz180L/xx8XbfaCCROw3W7evct1/jzp03QEdMWnc0o+/cRLgwgAUe9/EPrGG0x+fuZdd2X374/ZOtXAlpRk9+3HFBcRDZdv1LGxrbdtVbSKbTD9/jdT/eOPlQsXkAAYMKnWxP+xoXEowK1CM/RF05Ck/2OPYQAESBB4y67d0mHeaHQcPwEA2h49VUlt3cXdq48IwJmZaTlwwHrwoPvHcuAAX1VF0AqCVhA0DeIl5xeXX2pENJ3w5x/+ffuJACJgyR+KLSutXLgg695709u3r5o/v7G/xvXFp29fddu2omRs2rSZLSsDgNpVq9iqKgQQNv2ty/i8uhcuEQBqypfK7fGBAPha4zULeUklgkjSb/hwVUICAgQsW/rxx6YtWwOeeCLkpYkiQN4zz+RPmIBFMeL99/wff7x2xcqyz+YAxyNAyvgE36HDmhzmVX33fdHMd4g6sevuVACIeP2NiA/eF6zWzDvucFZWus6d56qqAYCvqsoZNNh5IcdLgyjCIxK3b6fDwjynqf9qrPsPFL36mrSKiQHili3T/j/LnxL80kRa7yNZVQyLF2OOAwDT+vVsjQEBhLz6SpMvvAg4+rPPO2Vnd8zM9PzpkHG+/dkz7c+e6Xj2rE/fvpds9UrakA4JbbN7V+LmzT597qV8fQUADEBK2qSoKH/KlIIxY1tWjxBE4PPPSUZizmG37T8A0voagCIw6HK3Bg3nlU3eqefBZuQruKQSKZ89G5S0KiEBA6YC/Nts2hjw+GNsYaFx4yZSoSAomqRoQqEwLFnGFhUGTXyxzZYtdGiICFjdti0G0fDzQi9xa5YuLZz6iufe4AAgAISOnxD19VcAQCiV/g895Nurp7ZXb8BYsFpyhg61p5/10iB0YFCbHdtVbdvCfwUmPz/vySdFjkWARIDIWbP8n3j8BssgvbQ3EToiQtuzZ52d7/RpJi8PAAwrV2IAWq/XP9BgfcodBIwB6IgIZWKiKinpUj/Nd2j2Gzo06a8D7dPT4376SX/HHQBIGjRRAIZfVzuaMRH4JwSPH68MDpH0iGHJEsfp045z6QAQPOklsqGt1AvPmJeLnikeCPUDOgxA16/UXAOXtIkEPPlk1oMPCgxDAuINhtyHHiF1Ws5kipk3L3bxIixiAEAEYdq8Kb1jJ9rXT7BaBbOJAFS7ZQu1b3/bvw541iY6naWz3gVvDYKDRo9uVa9ukEIRs7Dud9Fuzxk8xJqaSja0pFK+volbt6g7d8aCcO1ub7cSosORN2IEW1lBABIABz78SMRHH7Vsk42/c0RRMF37aPZ6ETJlsnnvXgAsiIJl9x5FVJTrbDoA+D/2uNciiK5Xr9otm6Xfmfy8xlUJRqNlzx7AACTpO6D/tekR1/nzjrNnEUHo+z5I+QcooqKCJ04MnjjRvHVb3tNPCSYTAoQBu85nNE7EdTmaGhSINrtxw++iy6Vq21Z/772ep0hfX58BA6p/WUUC2NPSCp9/XmRZkqIDn3328u1ob7/dtHs3AGAArlHuDgBgcnMvFu7d6ypuoSGXHIlQ/v7B48YrgkOk8DreZGRKSnibTdPlNmVioiqpjSqpjTKxtbpzZ95qZUqKebNJ0tDK8PDgF17w/tgwRhTl+fAKgAMeeih+9WrR4cgeNMiye8/FsiybO2KE+eBfXhqE0Gha//mntlev/Keezrr7HsyyiPrX65GCsWNtJ08SgETA2k6dYlsoEZaH3ZGrqPA66Th1ypWb17Ir5w1uqummfAcPVtf7d9SuXl35zdesxUwABI0f713y4YdIigLACMDacElYwn7sWPbjj+c88XjeY495fwl7+WJemppff80aNSrn8cdd5zMatD5kcMDjj1/sULLhS3Sl+gmNhzkW1V3L1xjyx47NmTjRsGRJ40vCpr9FKRQAIFot9hMnJBnctudL4T9yJEmQdb108FDjAs6z6QhAWnHzjPf35koP5CWViKp9e7+hQ0WnQ4p2kVxhCUBFU165MGxY3c/QYaUzZhD1jrLSjF4wW3yHD2tiuoEajEH8+/WP/+03rqws9/HHDTt2VC9cIJ3CAp/3xCjjzp1eGgTRioR16/X33Vf44ouGX1dbjx3lystv2Ujqf0j5Bx8a1q8nADBgOiAw4fcNLRQm79bpBEDNL6tEDz8OwWwqnDQJKModwEJcaUmo8ZpRXRpd958KhXcBigKxvoAoNPnBIYXCd/hQyYjoSEsr//QzBKBKbKO+rbNXSXXHjro77hQACADrkSPOM2e8Cpi375CeHt2dd1BeA3WP5/DyHhAETUs94jp3rrGwUgUIQO2VhcvTaUVowlxChYVKry4AiE5n3VUKBanRkgBNztPVHTtqu98uekgf9vrrl5FcQtO1q7ZnTyl9uu3oUSY/3/MsW1DgzMhAAAKAvk8fVcOst27BvH5vkqaVCGbZsnffzR40UHraEEUDYAwYAbYdO1q7ZUvdz9Yt9rQ06RQAJtQaBEh02LP79St7/33xElEtAmCfu+6O3/A7oVI5Tpwwbd1KAzD17moFY56r+fN/3k5oiIhftcp3yGAsCK7MLCooiPL3FyyWi4Fb/0KMGzaUfviBtBIJBBH/2xpVm8QWakv/YF9JVSFAjnPnsu6917B4sXnLloovvjzfrbs9OTl82jTp+RQBLLv38AaDYLEAgGi380ajMz2dLS6uiyfGom3fPt5gwBwLkjtiba152zaupkYqINis9qNH+dpa0eUEAMFq4WtqTP/7H2cxSQV4g8F29ChvrG38hIS8/DKlUgMA5jnscgJAyKRJTcYux/w4n9b7iAAix+WNfsp55oykxTDHWXbuMixfLi2mhH/wAap3chVMJq6iwrJnrzsA3bJnD1tSIphMgsnUhN8XxgBAAJR/9rmnx5rtyBHjHxuksCb/gYPUnTsDABYEwWTiKivNu3ZCff3Wvw6yhYWCyeTpgabp3p1SqaUBl3nbNq6iQnQ6jevW8w47AaDv06fJTzC4fjd7EUCTlKTt2YTfhzcIxcz/gdJoMIDgchZOmMAW10VIsUVF+c8+y5tNGIDS6mLmz5fUel0vlZdb9x+42Eu7dnOlpYLJJJib6iWvKN6yWe86z51L+N8fWBAqPp7tzDhv3bffp19fJi/PlpJC+foJDnvY668HPDlaWoJFSmXlN3NrfltDECTvsPveey8VEuI4cULTq5e6Q4ewN990f+GIdvu59h2YokIRQN+tW5t9++ochzBmCgoEoxEQoenapfCllyoXLGjshBa3ZEnQ88/XHWEYwWYDQaBCQnL69df1uSf83Xev3KG3GM4zZzLvuUewWKSvgtjvvgt5+ZJeQ9eFgjFjqlauRFA/YgQAAAGABIj94QdNly7pd9/t/kohFQpVXHyHzPP5zzxbs2EDOJ1ezw6hVMQvWhLwzNO2v/7KGjhQdLkabloGSKUKf+21yE8/Pd+ps/NCtuBq4M5DAIBKFTnr3fBGOesye99hTj4m6VYSER1zL1wqDZp17978555zFRcDAEmQ6o4dqcBAtqTEmZMtApBKZfTHH7u3cLYeOJA9ZAhiWN5jdIABKEQglZLU6tqdON4w4wSUf/hhwQcfUAAYQOHrp7/vXkKjdWZkOE6dlHrD94EHEtatk5Kk2NPSsu/tg1mOb7hYQwIQanWbgwe1da5rAAD5o5+qWvOrlHxQERBIaLSukiIRIHDAwIRNGxuP4wAAs9z5zp2dWZkiQPyixUH1jrZXxLx9e8G48VKoHq3VqTt3BsDO02c5hw0AlBGR8StXuuMqrAf+yh4yCBhW8NB6l+8luJRhFZFk+Afvl3/0ERUc7Pfww6XT3/bt28//iScAixVffBE2Y4Y06hbMZuvBv+JXrWLz8x2nTjlOnQqbMcPoH6BsFRv2ztuNqxUAdO3bJ+7YSajVjlOn1B07IIpWxsVBXBwAlLwxrXLBAs8FYEmDtPruu6Dnn69ZsdKwbGnC+vVUcDClVAKAKyvLdjzNp3+/f9ibtw68oSb30RG8xSIZU0PHjW9pDQIAsUuXKpOSalau5CurRJcLkSTp56tq1z7i3Vm6Pn2c588HjxgpZWkBjEWOo0NCAJCmc2febCEoqoEZG2OBYyX/JdI/wLd/f4KiPX3PsSiKHKtqkwQAurvvVsTHETTtnv8DABYFkeNUCQ2SBkiEvDqVn20lEBIx1vXsdZlEivoHH2x//HjFV1+bN2/mysudZ85gwKRKrYyN0/a4PfzttzXdurkLUwEBvn37IoJAVIOZFOZ5LIqkWt04TUbQ+PFIpTLv2MGVlPDVBtPGjRiAIClFeIQyMTF40ksBTzxxsX5fX59+/QGQ10wN8xxgTDXcOKLV0iWETmfatlWoNnC1NVBbQ4eF+Q8ZGj1vbpMaBACQgqYjIuxZmQq9j++woZfqk8b4DhrU4cTxii++MG3bxpeX24/+DQCkr6+2XTvfYcPD3nidCglp2Ev9LtVLRFO9BNA4ivfhR9xRj4LdjjE2rFzpPHdOivMzbd58DOBUUHDRa68VvfbaSX//ZADL/v0YY8v+/Y70dMOqVRhjwWbDguBZs2CznQoIPB0dwxQWiixbMGHCsfpYybqm338/uS6K1B3RC8kA5Z/OwRgbVqw4rtUdBbDs2yeVZ/Lzz8TGHgWonDfvUiGMtyYiz2c9+KA7bjXznj6Cy3XjWmcYtrLSlZ/PlJTwZvMNa/fq4HnM8+6Q0ysicixXXc0UFLjy87nKSsHhuL7iCE4nV13Nlpa68vLYsrLr1W+8yeTKybGnpjozM3ij8fKF2dLSk35+xwCKXnnl2poT2bpeYgoLuepqkeOurZ7GXNrzHyGkULgyM30HDiQ0Gq6ysvittww/L1L4+NAREeVz5wKA7rYumONyHx0RNGGC35DBylatFNHRrowMZevWXjFRIssqExNjlyxWxMQUjp9QtngRANhTUnV33w0AlV9/Xfrhh43dWCPfmRk2420AMP3xP5FlSIpyXbigv/9+rrw8e9AgV0EBAS3gPdnCFL8y1bR3r+TbroyKjlvz6xUNmdcRpFDQHt88tygkCZdawmkKRNFUUBC02EY2hErVEtsekb6+/3xrq+oFC1mTiUJE0IQJ19aclFGlJXrpcuFDmOMqv/ySySvQ9Lhd/8ADotXqMpviPvkk7O23TwUEiE5X0qGDZbPeLf3uW0QQfE1N8dRXeZOJDg+L+uorr0EdoVK13ryZCg4CAP/HRjLlZUKtEQs8ABh+/rlo2jQE4KlBeICIV6ZGflKXCDv+tzVcZaVgd9DBwUKNIWfQYGdmpjQXuO490qJUL1hY+eP8et92dcKG3xXu9HkyMpcAC4Lxt98wgP6++9SXyupw87icEiFUKmWbpOqlSzXdurgyMpStWrX64AM6IkKwWLCLwTwvOhx0ZETsZ59hp4stLhY5tvaPDbHzfyRUKtHplNICUCEhdFgYoVYDQo4zZzDDqNq1a7Nli9RE7a+/FkyciBq5sYa98EL0t/PYgoKS996L/OgjZWysolUrABAdjuwHH7SdPkVexRfVrYL14MGiqVPr1gYBYpcs/Uc2dpn/91h273ZeyEEAIa++egvmdr7sSIRhqKCgqK++MixcqEpq23rzJq6sjNDpmAsXBMaFALjyiuAJEzDPU0FBWX3uFWzWVj/84Ew/WzpzpuPMWUQSpE7HVVRoe/bS3nlH9fwfST9fyt+fLS4GhcJv6FBE0wVjxwLG3m6sT4xq9fPPrqzsgvHjag4d0vXoIdkdRYfjwtChlmPH/o0ahC0syhv1pMgy0gAq8p13Ap4cdbOFkrml4Q0G0eUSampKXnsdY4wAXFmZbGFnpFBQISG3jsf25ZQIUqmCXngeAPyGDy99Y5pgMbMlJdqePdmSYlHKu2W3kX5+tqNH1Wo16esbPOkl55mzXHW1/r57Q994Q0qCghmmdu1vhePHJ+3fp2pbNxLjKiuN63+v+nG+IAgIANXvOSEADhg6NG7VSiCI2tWrTYcOkQD2Y8nw8suYZXMff8K0f/+/UYOIDmfuiBFseVmdb/vwhyJvyS2LZG4p8h5/wrx/n7QeLz30hW+9VfzWW7SPb4eszOZEu1xf/lFKFWVcXODYMVU//iQYahBF1a5cRSqVWBCqf/iB9PGpWbWK8vMTbNba1atDX3018tNPMM9zlZVV333HFhSEzZoVMPqpmiVL6YhIAABRNP7xh/6++0KmTA6ZMtmweHH5l18y2dkiYADw69s3fv16yZ4SNmO6z4D+gs1G+fqCKOY/84xx6xYvN9Z/i0Wk4PnnrMfTJGOqtn2HlvJtl/lv4TfiUVWnjoggL3rBYoxFgVCpiCumqruB/CMlgiiKK68wbfiDt5iRgtbec7d59x5gWfVtt1X9MN929G//ESNiFy1Stm6NRdGyY4crO1t9222W3bsFo0m0WAiFErszaBNEzZIlVFCQtndv6969QePGBT7zjOPMGeuBA4aVKyM/+ohQqco/+cTvoYfUHTu6Uy0VvPCCYd06LzdWglaQWg0WWiQp7HWk/OOPDWvXSsZU2j8gYcPv15C3Xeb/ISHuJOy3Nv80uVvw5EmKhHiEkOl//6tauJC3mAGg6ocfqKBgv6FDI95/ny0p4crLHadPV339tfbOO5VxcYggkYJGCoVXbjxCo5G8Vspnf0JotYqoKG2PHtoePbCL4crLK774In/WrPCMzLhfVknli1+ZWrV0aeMxSOyK5cZff73FU4qY/vyz9P33L/q2r1nzX0picItQs2Jl7fp1ytjYsBkz5NWuG89VWHp9Bw7UdO/u/9hjiVu2UL5+tL9/681bfAcNEqxWzHMFz46xp6WpO3RAKrUyPp4tKFR37uQzcKDj+HHvBEUEweRcYPLz/Uc8WrN8hTs2DFGUeefOounTCQB7SrI0WSl9553y779raEHCIkCrefMCnnxSdDFXyN55U3Gmp+ePkSzHIALEfP21z4D+N1uo/xq1a9bkjh1j3Lq1bP783IcfuWK0mMx15+rSzFJBQfoHHwSAxK1bkILWdO0ColC7dh2iaL+RIyq/+DJx+zbSx4erqvIdMkRze3dCo8GC4BWLHfPjj9Z9+0Wr1e/RR9iSErd9SHTYffr18xs2jCkqImgaEKr47LPSOXMaO6HFzJ4dMnUq/IM81DcRvrY2d8RI3mKWjKkhzz0f8uqrN1uo/yDG39YCAAmIAOw4fpwrLb1ijLzM9eUac1W7rRUiw0pDhoDHHuOrqwmdrtWCBYReJ1itiKJAFAWDQYocRyQpOuy2Q4eVrVu7M3dFffmlu04sioRG4zt4sPRn1XffFc+Y0TiXYuT0t8NmzsQMcwsmMXaDRSFv1ChHdpaUt93nzjtjfpx/s4X6b6Jq2xZv2ijNcCm9nrz0JrAyLcR1S3hPBQdHvP8+FgRCr7MnpzAXLhgWLaLCw7Rdu4a88QYAIlSqosmT1Z06cRUV1gN/8dVVAaNGSS5kF6kfWRiWLCmcOrWhExoWAMImTYr8bE7+U087z5xpm5qCWjJhf3MoefV10+7d0nKMKjIqfu3alvCblgGA0Olv2ZKPOc6cITSaqDmfUaG3vFP/f47r9hLyNbWi3WbZsYPQahVxcZpu3eioSLawEElbQyMkOhz2lNTgiRM1t99u/P13y84d/o89Vj7nM3W7dr7DhnqqA+NvawsmTGisQYKffTZm/vzCF16o/nU1AuBKS5HiVkxKZFi8uOL77+p821WqhA2/X2p7IZnmQwUEJO3bxxkMhEp5qT0GZFqU6+BCi2hKsFhKZ75TOPElVadOhsVL6LAwwWqN+vzzgNFP1a2eYIxUKk23ruYdO3mDAZEUoVYrExJEi9meklL721oAAISQUmnauDHnyVGCKIoAAmDphwcIfOSRuGXLAIAtKVWEhdHBwYLNhm49bwvboUNFU6Zc9G1ftEjb69qzV8r8IwiCDgmRNcjNorkjEUTTgDGhUnGlpbzBQOr0mu7dBJuNCg4idLqAp58SHQ7BagXAmGVjfvqpZsVK7HJigadDw2x//y06nPaTJ6XAPASAnU5ARPyyZYikPJddEEX5P/qoFDXQeusW0WbDgkD6+AiOW8sUzxYX5416UmDqfdunTw94+umbLVQDmIICvtogGI2ESkkFB9NhYVLmdMwwotMp2O1UYCChVGKOwzyPOU46LrpcythYyQjFVVSwpaVCba3kfK1KSPBKgSE6HGxREW8wiHY7odWSAQGKqKjGaR+xIGCWBUEQWRY7nYLTSWq10lY7mOOY3FyuogJzLOkfoAiPoCOb2HsJ8zxm2br/GUZwOhFCSo8cJRcLMIzocokOhyI6WnLT4mtrJSERSVJBQYqYmH8SUMsUFPDV1YLRRKhVVFCQV++JdjsZGNh43spVVnIVFXxNDfA86eND+vu7xWjidjgOs6zodIpOpyImRsrqxtcY2KJivsaASIoKDla2akW4N+67BWikRDAGAL7aUL10SdALL9D1gcOOEycqv/8eeB55pJYRWYZQKBWxrTDHqZKSlLFxXGVF5BdfAMaIJAWrVbTb6bAwvrYWALAgkGp18MQXAcB/ZLTu7rv56mrCx8f/kUfYwgIAwBgDQfgNvULCFURRF521biWfVdHlyh0x0lVWKhlTA4YMjfz005st1EXMO3aUz57tOHGSdzqkqAUKEXRoiLpTZ9HlYouKBLNJYFxt9+0ng4JyHnhAdDoBESAIIssgQO3Tz9Lh4WXvv1+1cKFgNNZt301RbQ8e1N5xh9SE6HRWL1pU9e13bEE+L4qSszYFQEdHB780KfTlKZ7puys+/bRi/nxCEAEhzLI84wp9aVL0N1/bjhwpmjrVeeqUKAgAQAAQvr7+I0dGffYZ5RnGjnHu8IdsqSkIESCKmOcEhtF26dr26N9153k+Z+Agx+lTUgGRZTDDtP37b0337lXzvi3/4guuvEySEBEEFRkRMWNm8EsNNgZv0Hvbt5fPnu04eZJ3Oj16L1TdqZMUaypYzCLDtNm923MzSuZCbvnsj02bt3C1NVKmMAKAomg6Jjr09deDX3zRPYsXGSan/wDH+XOEdDssIzJsu+Np6o4dK774ouKbb/jKynppSTo6KuK999y5/m46jZQITfPV1UVTp5avWUMHBgaNGwcAzvT07EGDmKoqz8mDCKDv0DHyo48cp08hihJt9qBxL2huvx1zLOZ45/kMtqTYvGNnqwU/eVYvmM1VP8wPeeVl0teXDguLaNdWMFsqPp0j5dpq6bttUQqff96amlLn296uXdyqVbdOwGXx1Knl330HAARA4COP6O66m8nLNSxdxlRUMBUVAKAIDiGUKlAqEU0jAKRUEiTJFhRIgRtS3tP80aMrN2ygAXD9NFjkeffWTYLReOHhh80HDyIAUqkKuP9+dft2zIVcy549ruLi4ndmGNeta715syKq3hmMJEmdXqyt5Yy1Uo5IQq22HzuW2acPL4o0AIEIAYsYQDCbK5cscRw/kXTwL9LjGxjRNOHjwxcVizwHACIANEhNiKQCXGERrk+JSKjVJdOnF3/xBQlAkZQo8BgAiSJXXJI36SWurCziow8bRyQUTZ5S+eN86a4DH31Ud9ddTHa2YflypqKcqSgHAEVIKKFUIqXSMwOGZc+e3Cee4GprAUDfvbvfsOGEVmPZs9e8c4crL69gyhTLjp0Jv693LzIimqb0eragEGMRJH2hUJa89nrxvLkkAEXSosBhACQKTGFh7gsv8FXVYW9Pb/6zcR3wzFBUOmtW/pgxZbNnHwH4GyB/7HMYY1dOzunomJQGOcdQMkB6u3a82WTZf6D49dexKGKMeZNJdLmKp71Z8vYM27Fjpm3bCie8iDHmamoy776bq6mR0itl9ulTOX8+ZzA4Tp22HjyEMcaCgAWhZOZM0+bNV5VSKeuBB8s++uh6JGdqLuWffCplZksFOOnr5zx//mZLdJGKr7+RZEsBKPv4Y/fx2j/+SCVJ6Xje6Kd4o5E3m+sSXgmCyDCFkyYlA6QCnAoOLnxpUgpAyYwZjjNnS997L5UgpZt1p6fLGTBQKnxcpbb+9Ze7FfvJkycDAlMBkgEyevYSnc66E6IocrwrP/9UUHAqQApAwbjxZ9sknQgIKJ8zx3H6tOPU6eI330wjKemROwZQtWBBgxsTBJFlDcuXp9Snicvo2atxgaofvk8BSAM4oVKXffBhCsD523vUrl/vzMy07N+f1bdvKkAaoFSANES4srK8eq/888+PAUgSln/22cXeW7fO3Xv5Y8fW9V59NjZndvYJX78UgBSAwokviR6J/irnz5cuPAZQPmeOl7Tln30mfVgn9T6ls95NBsi44w7jH384M7PMe/Zk3nuvW9rjNO3Ky7uaB6Gl8E6PmDtiJFdTU71kSfnX3xg3bGCKi8+0TkxuqEFSAM7ExbOlpVxNzanAoKLJkzHGhlWryj76qHjam4YVK84mJFQtWGDetj3/mWdxQyXCm83mnTsz7rzLfvKkYfnybCnHL8YY45J33vmXKhHjnxtTEUoFSAVIBWTauvVmS3QRwW4/ExWdIr3eShVTUOBxTkxPTEyt133248e9rjUsXy599McpOgWgdNYs96nT4RHHAJIBLAcOYIyNf/4pvajJAMVvvulVT+n7H0j1JAMYVqzwPCUKQnrbttKLcVynO6HXO9PTPQsUTp7sTiWZdf/9jW/Qef58Wv3L7K1EMMYY21JSpHs8TlKpFJU9YKDIMBcFYNn0tm1T6sWr/e23Br1ns52OiJR674RKzRQVXbyQ58/GJ1zsvZMnPS/MGTxEUqknfXy56movkc7f1kWq86R/AFdV5XnK+tdfUk8ep+hUgswZPtwzj6HgdLobTQG42velhfAeb2OepwICgp5/Puz113z6988ZOMh1IcczbkUErIiIaLNrF1Iqz3fs6KgxAE0DAJufp2rThquowCwXv26dMi5OER/n75HJtv56kQ4NDZs2jS0oZEtL+apqacPEfy+uc+fyx4xx+7ZHf/WV21/uVoDJzWXLyqSPmdTpGhg4CUQGBmIAACQCmLdt877YvVEMz1E+viGvTnWf8XvkYb++ff369ZPsFJVz59ZZSQD5P/aYVzWBTz9FKVXSPruVX3/TYMtOUQSClK7lbbaI9z/w2gAlaNw4kpTyogNXWYX5JnbnRoi4vG2sbrMLgUeiGD33G09LMKJp/f33uy/nyso8L3RlZnHl9b3n5+dpfEUkSXn0nmXnTvcprrzceuigFDClveMOqlFGQm3v3pKBgzfWui5c8Dzlnh6KPEcQRPQ333h6PxAqlfauu6QNaDAAX1V92fu+QTSyidRPCAWTKbtfP/u5dC8NQgcFtdm1S9k6gauooKOiVCQpXYKUKntqqt/wYeqOHVX1GdxUSUlQv5WR9D/p56f281PfdhtXUaHp1gURhO3QIVXDjG+Y4+zJyfa0NG337rq77gKC4A0GpFA0tvCTej0ITTxVNwzBaLwwciRvNtX5to8ZE/rGlXcVupGIDicWhbo9RGgKGhqeEHnxAWjiiay3W2NpF6jAiy9DzPyLDriiw8Hm5tVt8qBWSVsoeEJHRNChoUxRIQJwZWayxcXK+PhGkmKSIBvHFlGBgYRKLdjrd9tqbEq/onHd4y7UCa2V8d4p5umw8It/NDSIiE4Hxriu9xQKb7Odh82LK690/2498BdntUrWMXWnjo0lUneUDiIRMJOdo6u3TDeQGkDVvp0iNtbrOBUcfClpbxYNlQhCUo+LNtuF4cOtaWleGoTy9W2zfbuqdWuutJSOjGyXkmI98Jd521YAULdvT/Xpo+3dGwBc2Tn2lGSmsJDS6dSdOlGBgZhh2bw8wWJhcvOAJFRt2qjatCHDwoInT3YcPw4iBuJiQ1xVVfaDfTmW0SQkRHzwgd+wYbW//cYVlwRNGE+Hh3uujYkci2/iAo0o5j052pGZKT0uPr17x/z005WvurEoYqIpvZ63WgFAdDhFp9NTF3uGqykvvXUWBlAlXTL4mK+ulhbgQLLIarVeBRBNE1qtZJjELMMbahorEQxAKhRN7FN1XT9fOioaKRvtyYAvGYGljIsjNVrBYQcAwWIRnQ7Pu8PMxc10VO2S3L87TpyQfiEAmf74nyujwS6cAMDm5xP1wehsUWGTTWMAZVxcE6sNt168WAMlQup1mOOwIOSOGGk+dMgr+p7UaFtv3Kjp3j1n8GD7seQOZ8/QUVFIrZYGvb5DhwKA49Sp0nfesezdK7Bs3YoUAKXTK2Njs+67nzfWSh1AANBhYaGvvhoydar+vvvq28DSGnvVt99xLEMBhLz0Ena6bEeOlH30MeWjZ/LzQ16eovPYNBQ7nITipkXQFL/xhnHnjrq87RER8evWNblX282FDg/X9upVu2cPBcDbrFxxiXtzbNFu58rKkPThAvg88MDlKrr0ShNfW3txO0iCbLxFJiJJon4GgQGknc+apqW/Eq7ym5uOjNT26mXav48EECwWtriUCqobCAhWC+vuPURcfIwBeEO1uzVXXq4rL9frrggAglaAtLvjZe74Vo3q8KLBk0EGBnJVVQVPP2Pc1WgrXIUy4ff1+nvvzRk0qHbHDtZklLbkQyRR54NUWlr82usZPXsat2/HLIsASCmFIkDwiy+2S0sNe3OaUK9WMABXUVH09tvnO3e27NkjbaeIaLp6+XLTn39Wfv+9Kjw87pfVAaNHY4HPG/0UV13lys01b93i9YAKNhvZaPB8YzAsXVoxb57k204olfG//954Z7BbhJiFCzWxcQKAKIqlM2fyRqN0vOLzz6UVSgEg7K3pqvbtL1fLpV9vRBBXHFffzAFj82i1cKEqppUAIIhC2cyZgskkHa/45FO2qhIABIDwd96RZu51uG0CgIOef75TTk6nzEzPnw6Zme3Pnml/9kynM2eDJ790ybb/JZ3WQNUpY2Ntaan2tFQvDQIEmbB6te+gQQCgbJ2oLSnBPC99+XClpaY//+c8edL299+syUgASN/Mvvf0ifziC8yxeaOfEuw2zHKiy6UKC4/9eSGTm1uz+lfHyROkCKLDkfvww1RwsE/ffs4zZ8wpyTWrV4sAQUOeDnhqtO3gwdLZs7HLhQApoiJ9hwwh/f1BFN3fiphh6IhwuOHY/v67aHKdb7sIkLBwYZPT2lsEZXx822NHS6dPN+/ebdq1M6NLV23vXmxeniUtDQBIvT5i6tSIjz++5vrJgEBSo+FtVnD7oTbE8yACRKhuufHaZVAmtm537GjJW29Z9+4zbt/m7NJV27Mnk5trPXEcAEgfn4jXXo/44H3PSyS/WwnK3/8/n5qggRJRREWRFCV6eOxI07b4ZUv8Ro5gcnIUcXExP3yPRRF4HikUjpMnCsZP4KqrHOfOIQCyPtmyvkeP1tu3YUEAQYhbvvzCY4/Vrl4NFJW4cRNfXWVLO66IiXGcPAEERH35pSImxrx5S+XcuVgQFFodYIwRWPbttR89qurQIWnrtrynn3Kkp1M+voiiSt+eEbfmV2nWgxkGM4yUDvpGwpWW5j3xhOBySsbUiGlvBo4Zc4NluFoof3//UaN4o4nbtNFRVOgqKqR9fXWdOvsM6B/80ktNmTmvpvKgQDIwsE6JuFyi3e5VALOsaLNKI1BCpaZCgpuq5taFCgwMeHKUYDIxW8ochQVMYQHl66e77TbfQYOCJryojIv1Kq/t0UPajhQA2IImTB6Y522HD2GWAwBtr17/fAurW5MGSoQKD6cCg9jKCunPuiyEP/wQ+OyYmmXLc1+a2HrZ8oAnRyGCAIXClZmZM3gIV11FNDS+6jp1Sty2DQtCVp8+XHlFp7zcjuln7ampmq5dFTExfE1N6ax3bRnnKQAAVDBmLB0aKmAx9NVXPVcQ2cLC7P4DkFoFDCuYTQQg+/lztvPn2vzvf+7YBMFqFR0O9xz1xiD5tjMlJZIG8R84KPLzOTdSgGtAcqk2H/wLADRt2oTNmKG/6y4qOJj09b3CNMTz7KVLEmq1qn17Z2EBCSAwLq6iQtlwk10mP5+trAJpybN7N/qqYpqvuABxVQWaLHvZ2xSdzpwBA82HDgKAtm27sBlv6+68iwoKvEyiXF2fPnRAAF9bSwDYjx8XXS6vgBq2pCT7gb4CFhFAx1On1bd1/ofCXE7ym0cDmwih1VJBQfXzMCwCRH/2WfDkyYYlS3Kff05gGOuePdI5Ji8/e+AgtqLCS4OoE9sk7thBBQVl3XOP9fRptqqSycujIyL8HnpIERMDAKLDEfjM07oOHaVWMMcyJcVMaSnp50uHh7t/lImJwPNcVRVvNklWFEqrDR03jvTzc1unnefOYZ6/wdOZwnHjLcnHCEAiYE1SUtwvqxBxq3vr8waD7eBfkjUq8tNPg8aOVSYmkn5+V34EiX/6jIa99aZ7cmdYutTrrGHRIoFjpZFI2PS3kIeNFlGU58y/caIpRJIX1yMwRrS3rRGR5OVtBw23Ir/SnTTqE668wnrooNR7UV99Gfjss8rWCZdPtU0FBPgMGCiF2DAFBbbDh70KWPfuFbGIABTBIXRMA1OaW1oEAE0mIfe0cN8aKzUNlAgiSUVCPAaQ8ndEzZwZNn06ACjj43W399B36lTn81NWljNoEFNY4KVBlDGtErdvoyMiQBR1d92t69ZNe9ttuKEfhyI62nf4MMEorQhiAIQAkYCqF/6cdf8DWffem3XvvVn33XdhyFDMsgQgVGeHBcHhVLVtp7/3XncnWrZuU3fo0Nh5pOWo+Pzz6tW/SMZUyse39YYNjX0ibkEUYWHBL06kQ0MRSZbOnFn988+OtDRXdhZbVMTXGHCDeBMAABBF0W7na2osu3dLBxCA/chhrrRMtNtFh6Pxs6u/777gZ8fwAASAYdny2rVr66rF2LxjR/WSpQQADxAwbLhPvSee6HIJVqs9NZUrL5deUYFlHKmpgtksPTOY5wWTybRli+B0SAW40lLHiROizSa5q4kOh2AymTZvFgQeAUIATF6uMz1dtNmk1kWHQzAaTZs2S95ZkpeKKztbtNvrXBlcLr662nb4CKq/Tcvu3VxlpWi3u+9RERMdPG48HRqCSLL4zTcNixc7jh93ZWezxcV8TU0TvQcAANFzv1FFRQsAALjguedsx465NZ3z3Lnyj2cDgAgQNuNtyt9f6ihJWvO27VAvrePUKSY3T3Q46qR1uvjKKufxNLe05m3b+Koq0eEA8WaaYJGX2dyweHHe+PEAED711eh5c5m8PFKvr/NvwSIggjcYsh/saztz2tuNNTQsad/eJi38NctX6Ps+qIiKAowr584rmT4d8zwCTOj0os0qNY8AeS12ofo9exBFY54DghREIWDYsFaLFkmLlBndugeNeyF40qTr3SdNY966JWf4QyCKkmCJm7f4Dh1yY5puPqLVaty0qfLLL62nT0v+GgiAQIQ0ANT16RM0dqw774nj+PHsBx7ALMe5nBezQgFQFI00alKlTjr6dxOOHhyfP+bZmjVrpE9N06GjMjaWLSmxnz4lfa7+gwbHr13jTl+YM3CQ9e8jotUq1k8ypAsJnS5p61Zdnz61v6zOn/iiaLdjjwIkAPj4tPrqq6Dx49PbJLFlpbzdDg0LIB+fuJ8X+Y149FzrNmx1Je9weN4FgUAZGd3ueBoVEpIzcJD5wH6RYRrcpkJB6n2SDh9y5+UXLBbTxo0Vn39hO5fesPf86PAw/b33Bj43VtvDe0dUx6lTeaNGObKyAIAA0NzWRREVxVdX21NTpYlM8NjnWi1eJA092JKSzJ69eLOpkbRIGdOq/elTpK9v9gN9LUcOiSzrJS3l59/kJ3LD8B4c+g4eTNGKgGeeiZ43lykszOjdWxUfn3TkMCIpQIRgteYMHdpYg9D+AYnbt6naty995x1Nt27+I0e6zxp+/rno5Vc65uUCACCkiIkOGj/OkZxC+vlSoaE1v/1GabSgVOi6395q0SKRcQEGpKCte/cWTpyoCAnlqirJwIDAZ581LF4S+NBwOjJScjYTjEa2rEx3911wQ3BlZOQ/8yyIIgIkAG71+Rf/Ig1i+PnnstmzudIyURT0Xbr6PPigIjqKrzXajhy2HviLNRrt589XLVgQ9eFH4bNmAYEIjVbTtSsghGjac3iPeR4LAqFUEk1lt0U0Ff/rrwGjRlV+9ZUrO9t1Lt1xLh0BKIKDFQkJoS+/HDB6tGd5VZtEwekgabqBE60gCDwnJcugAgO13buTCoXnAB7zgsix0reaulNHOiKcoBWe0y7M8yLPkYH+gJC6cyfaEkMoFA3uguMIjUbyFVC1SRRcTlKh9EihB5hngaDcLj/VP/1U9umnfFkZFkWfbt30DzyoiIria2utBw/aDh5kjbX28+crFyyI/uijsJkzPRvSdOnSLjm5cu43xvUbuNISx+lT9tOnCEBUaKguqU3otGl+w4a5CxO0Qn3bbaLLSTTsc5HjKJ1eUjSqpDaiyHtJK/IsQSua/ERuHI3DadLbd6j55ReR406FhBwFSCMptqICYyzY7Zn33ecVjJcKcEKvtx4+jDGumDs3GeBsfLzIslJVtevWpSB0QqNhy8vd9RsWL8l/7jnr4cMZPXrmjRlTPG2aMyvrlH+g7e+/pQIiw2TccWfJO+9YjxzJGTo04447DEuWVn77XcG48UJ9DGjV/PlnE1p7RlK1HLzRmN6uvTtGK+/pZ25Ao9eLso8+cgehln7wIfYIJ8UY244dk0JspR97mncM3rXB19Yy+fnOjAxXXp4UePkvpfS99y6G8M6ZI0Wru7EePnzCz8/de46Tp5qsROQ4rrLSmZ3tzMxkiop4k+mGyH7jaEKJVHz9dXrbdqLLlfvEE+duvz2jZy+2pERkmOyBgxprkOMqlWXXLowxk5+fCnAMII0g2bIyjLFp69Y0WpECcNLXz1OJSGG75t17HOnptuRkweFg8guOq9UpABcefqRg/ITTYeFHAaTwXOvff7MlpbXr1mGMsSi6Q63TO3SonDu3pXtHInvQYHcg6fkePQW7/ca023w4o/FUQKAUMHo6PEJwOBqXKX7jDXeIbfmXX954IW9ZOIPhpJ+/pCDOREW5w809KZoyxd17ld9+e+OFvBVowq82aPz48k8+sR07Fv/bb3WjFUHIGzXKuGO7txMaRcWvXavv1w8AFK1atUtJ4crLsYuhgoOtBw/lPvY45i7O39wgpdJ55qymcydAiMnLK/vgg5plyzDH+w0YYPrzTx6wb+87CLW69L33nWfO+g4domrTRnfnnc5z5xTR0ZIZ1Z6czBUV+zWKFm0JSqa9ady+TfKgU4SFJ6xfd0ttg3p5+PJywWyWjDiKmOgmvfLVHlGzfHnFDZTuVoevqBAsFpB6rz47pBdKD0dV3mC4ccLdSjShREi9PmDUkyXTp7c7dkw6UjhuXM3vv3tthQuA4leu8hs+nCstpcPCgCS1PXpIZx1paReGDxccdqKRuRQAAGPzli32Y8eAQEETJtAREWx1tV///ok7dpzvfJv97Jm4X1YxOTkZQ4eKDENHRhoWLTLv3KkIC4uaO09SIiWvvR44ZswN2DCxZsXK8q+/qvNtVygSfl/nvcfFrQ0VGkro9aLJiADYwkIp6alXGcuuXe7fNd263lgBb2mo0FBSr+PNZgTA5OWLTmdjLWw7cMD9NalumMTg/w9NR1VFzJ7NZGRKq01FU6ZULV/uuQ1dnRPaop8DnhxlO3joTIcO1YuXuK91nj2bPXiwFB3fdJsI0VGRxh07uPJyV2YmX1GRuHGjulMnABAdDgzA19QQPj6Rr70W8OQoy85dIstaDhxASiWh1QCAZdcux6lTodPfuo690CT2Y8mFL73kNvvHLliou+vulm70+kIFBPgOGSKFLDEVFSVvv81XX4z3FyyW6gULajdsIAAEwJqEBJ8BA26itLcaVFCQz6DBdb1XVloy/W2++uJYQ7BYqr7/vnbjRqn3tIltpCH5/0O8l3jdVH71ddWP8/2GDqv4/rvG29DFzpsXMnWqZc+enKFDWYYJHjK09ZbNAODKycl+4AHJobOuNGBSo+l44cLFgAJBMG3cJDgdxrVrnSdPdSwsAIwFs5lQKtNbJzoryhNXrw4YNYqvrqZCQ8tmzapeujTi/fdJHx+fAQNIvf5sbFzIy1PC3n67RfuFKy3NuONOprhI8kwNf+216G++adEWWwjRbs974gnj1q3Sx6zw89fcfjsdHCyYzY4Tx10VFQCAAHQ9esavWa1M+I9HeVwtos2W98QTxm3b6nrPP0B7++1UUBBvMjlOnGAq63uvV+/4Nb8q4+JurrQ3i0vGGodOe8O4YUPp99/RAF4aJHr2J9JWuKROq0xIUHCc5AzDFhfnDBzkqUEAQARQx7RqYEcgSb9HHwGAwCdH5fQfyJWUujIyfAb05yorpSkok5sLBOHKyVEhxFVVxy1f7tO/LldN4cSJpK9P6Ostm/gHs2zuyMfcGsR/wEDP7T7/XRBabestW0xbtlTPn+/KyuarDdY9uzEAAkT6+2mSklTt2ge/8LzvoEHwL0+U3RIQOl3rrVtNf/5Z/dNPrpwcvtpg2b2rvvf8NUlJ6o4dg55/3nfgwFsnKfeN55IjEQBg8vMzevTgamrqlQIWACLffjtyjke0iCBgjgOS5Gtqsh980HH+vLcba2RUm317VW3aNNmEZdcuV3a2de++0DenGdetq168WHQ6dT16RH7+uf3oUba0VH/PPT79+0texrXr1hU89XT706euELTebArGjq1asaIuM1XrxLZHj9zgCJ0WQnQ4RLu9LjshQkilInVaRDdK0iPTFA16jyAIpZLQ6RonT/l/yOWynijj4mKXLLnw6KO4zskKwidPiZwzhy0pMa5bHzTuBdLHB0gSkaRgNl8YMsR+/ry3G2twSOL2bZfSIACAaNp27JgtOVm1dauqbVs6KNhVVOjTv789Odm8bbtgrFUmJEijGHtKSv7op+J+WdXSGqTyy6+qVqyo823X+yRs2PDf0CAAQGg0/6KlpVsNufcuyRUXgSvnzUuWMt+/OBFjzBQVZQ8cdATAtHmLVIC3WDLuurtxRvgTfn72lJQr1s8UFdWuW18y453T8fF1ScnV6uy+/Sz799euXSuVcZw6dUKjLf/002teyv6HmLZtSyVIdwpv459/tnSLMjL/dq6sRDDGZR/PTgEw796NMc4fO1balab0nZkYY8HhyOrbrwknNK3WcuCvK1Vch+h0GjdtZoqKMnr3TqVo865d9pRU14UL0lnrkSPHtbrSd9+7phu8CpyZmZL7Zp3n1adzrnyNjMz/ey5nE/Gk6vsfit+e3ur7H/yGDjFt2sTV1mrat/cZOCBvxGM1mzZ651JUKhP/3Ogz8KrXC7mKCuZCrmdEjGHFysJJL0V9+FHotDeutrarQrBYMu+8y3EuXTKmBo96Mm7Nry3aoozMf4N/qkQAwLxtW96YMf7DhrdauECyJ+WNHm1Ys8bbjZUkW69b7/foI6LdXvPLL/6PPHptmawEk6no1VeNGzfGL1vu9/BD11DDVXFh2LDaLVskY6qu++1Jfx1o7JclIyPTmKtYl/IdPLjDiROunOwzsbGmjRuLXppkWLPGy40VA4pbttzv0UcEo7F01qyciRNrVq28BrFMmzal33abKyu7Q1raDdAgJW9Nd2sQRUho/Pr1sgaRkfmHXMVIxE31goVlsz92lZaSAMjLjfWnn4InTgSAyq++ynvzTQAIGf5QwsY//3nl9mPJJW+96czOjpg1K2TKlKuV7RqoWbUq79lnpb2XEE0n7d3ruSuFjIzM5bkWJQIAvLG28quvDUuXMRV1aamQShXz9dfuFEF8dXXN6tV8bS0dGhoyefIVKxQsFtuhQ+WfznHl5weMeDTi3fduTDpfe2pq1n33iQ4HAhAA4hctCho37ga0KyPzn+EalYgEX1NjWLLEsHy5MyNDGRkVv26tKjGxwTZ/V6yhutqVnV27Zo1p82ZEUgFPjgqZMsUz436LwpVXZNzRmyksrPNtf/mV6O++vTFNy8j8Z2iWEpHALGtPTq5evNh25Ah2uRQxrXz6Pqi74046Ipz09SV0OncMNWYY0W4XzGauvNx29Jh1314mLw8plepOnUImTdLd04dQqy7f1nUEs2zWAw9ajhyWTCF+ffu13rZVdkCUkblaroMScSM6HMyFXPOO7da9e9nCImlHThBFLAiAMSCESBIIAlEkoig6OtrnwQd9Bg5UJSbeFCtm4fPPVy5bJmkQVXxCu2NHr2oMJSMjI3E9lUgDRFGwWEWHXbBYBZMRCwIiSdLPn9TrCK2W0Oub2Kn4BlI1d27B66+TUi5cra7t4UOaLl1uojwyMv9eWkyJ3MJYdu7KGTIEC7y0VXDrP/7wf+SRmy2UjMy/lX/HtuPXEVdubsGECaBSkqDCCKJnzpI1iIxMc/j/OBKRkZG5jvz/zaQiIyNzXZCViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs5CViIyMTLOQlYiMjEyzkJWIjIxMs/g/gcb1BBr3xo0AAAAASUVORK5CYII='

    # Header image export path
    $HeroImage = "$env:TEMP\logo.png"
    [byte[]]$Bytes = [convert]::FromBase64String($Picture_Base64)
    [System.IO.File]::WriteAllBytes($HeroImage,$Bytes)

    Function Register-NotificationApp($AppID,$AppDisplayName) {
        [int]$ShowInSettings = 0

        [int]$IconBackgroundColor = 0
        $IconUri = "C:\Windows\ImmersiveControlPanel\images\logo.png"
        
        $AppRegPath = "HKCU:\Software\Classes\AppUserModelId"
        $RegPath = "$AppRegPath\$AppID"
        
        $Notifications_Reg = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings'
        If(!(Test-Path -Path "$Notifications_Reg\$AppID")) 
            {
                New-Item -Path "$Notifications_Reg\$AppID" -Force
                New-ItemProperty -Path "$Notifications_Reg\$AppID" -Name 'ShowInActionCenter' -Value 1 -PropertyType 'DWORD' -Force
            }

        If((Get-ItemProperty -Path "$Notifications_Reg\$AppID" -Name 'ShowInActionCenter' -ErrorAction SilentlyContinue).ShowInActionCenter -ne '1') 
            {
                New-ItemProperty -Path "$Notifications_Reg\$AppID" -Name 'ShowInActionCenter' -Value 1 -PropertyType 'DWORD' -Force
            }	
            
        try {
            if (-NOT(Test-Path $RegPath)) {
                New-Item -Path $AppRegPath -Name $AppID -Force | Out-Null
            }
            $DisplayName = Get-ItemProperty -Path $RegPath -Name DisplayName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty DisplayName -ErrorAction SilentlyContinue
            if ($DisplayName -ne $AppDisplayName) {
                New-ItemProperty -Path $RegPath -Name DisplayName -Value $AppDisplayName -PropertyType String -Force | Out-Null
            }
            $ShowInSettingsValue = Get-ItemProperty -Path $RegPath -Name ShowInSettings -ErrorAction SilentlyContinue | Select-Object -ExpandProperty ShowInSettings -ErrorAction SilentlyContinue
            if ($ShowInSettingsValue -ne $ShowInSettings) {
                New-ItemProperty -Path $RegPath -Name ShowInSettings -Value $ShowInSettings -PropertyType DWORD -Force | Out-Null
            }
            
            New-ItemProperty -Path $RegPath -Name IconUri -Value $IconUri -PropertyType ExpandString -Force | Out-Null	
            New-ItemProperty -Path $RegPath -Name IconBackgroundColor -Value $IconBackgroundColor -PropertyType ExpandString -Force | Out-Null		
            
        }
        catch {}
    }
    Function Set_Action
	{
		param(
		$Action_Name		
		)	
		
		$Main_Reg_Path = "HKCU:\SOFTWARE\Classes\$Action_Name"
		$Command_Path = "$Main_Reg_Path\shell\open\command"
		$CMD_Script = "C:\Windows\Temp\$Action_Name.cmd"
		New-Item $Command_Path -Force
		New-ItemProperty -Path $Main_Reg_Path -Name "URL Protocol" -Value "" -PropertyType String -Force | Out-Null
		Set-ItemProperty -Path $Main_Reg_Path -Name "(Default)" -Value "URL:$Action_Name Protocol" -Force | Out-Null
		Set-ItemProperty -Path $Command_Path -Name "(Default)" -Value $CMD_Script -Force | Out-Null		
	}
    Function FormatSize{
            param(
            $size	
            )	
            
            $suffix = "B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
            $index = 0
            while ($size -gt 1kb) 
            {
                $size = $size / 1kb
                $index++
            } 

            "{0:N2}{1}" -f $size, $suffix[$index]
        }
}

process{
    Set-StrictMode -Version 3.0
    
    #####
    $toastExpirationTime = 30 #minutes
    $Script_Export_Path = "C:\Windows\Temp"
    #####

    $RecycleBinSize = (Get-ChildItem -LiteralPath 'C:\$Recycle.Bin' -File -Force -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    $RecycleBinSizeFormated = FormatSize -size $RecycleBinSize

    $OpenRecycleBin_Script = 
@'
start shell:RecycleBinFolder
'@
    

    $ClearRecycleBin_Script = 
@'
powershell -command Clear-RecycleBin -confirm:$false -force
'@

    $OpenRecycleBin_Script | out-file "$Script_Export_Path\OpenRecycleBin.cmd" -Force -Encoding ASCII
    Set_Action -Action_Name OpenRecycleBin	
    
    $ClearRecycleBin_Script | out-file "$Script_Export_Path\ClearRecycleBin.cmd" -Force -Encoding ASCII
    Set_Action -Action_Name ClearRecycleBin		

    $Action_Open = "OpenRecycleBin:"
    $Action_Clear = "ClearRecycleBin:"

    $Title = "Your recycle bin currently contains $RecycleBinSizeFormated of data"
    $Advice = "We advise you to empty your recycle bin to free up space on the harddrive of your laptop"
    $Text_AppName = "University of Groningen - System information"

    $Scenario = 'reminder' 

    [xml]$splat = @"
<toast scenario="$Scenario">
    <visual>
    <binding template="ToastGeneric">
        <image placement="hero" src="$HeroImage"/>
        <text>$Title</text>
        <group>
            <subgroup>     
                <text hint-style="body" hint-wrap="true" >$Advice</text>
            </subgroup>
        </group>		
    </binding>
    </visual>
    <actions>
        <action activationType="protocol" arguments="$Action_Open" content="Open it" />		
        <action activationType="protocol" arguments="$Action_Clear" content="Empty it" />		  
        <action activationType="protocol" arguments="Dismiss" content="Dismiss" />
   </actions>
</toast>
"@


    $AppID = $Text_AppName
    $AppDisplayName = $Text_AppName
    Register-NotificationApp -AppID $Text_AppName -AppDisplayName $Text_AppName

    # Toast creation and display
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-null
    [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null
    $ToastXml = New-Object -TypeName Windows.Data.Xml.Dom.XmlDocument
    $ToastXml.LoadXml($splat.OuterXml)	

    $toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)
    $toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes($toastExpirationTime)
}
end{
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppID).Show($toast)
}