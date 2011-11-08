Content-Type: multipart/mixed; boundary="===============8390436512765479855=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: CDMA modems and oFono
Date: Tue, 08 Nov 2011 20:42:04 +0100
Message-ID: <4EB9860C.8020400@linux.intel.com>
In-Reply-To: <4EB448F5.6020802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8390436512765479855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 11/04/2011 09:20 PM, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 11/04/2011 08:00 AM, Guillaume Zajac wrote:
>> Hi Denis,
>>
>> I have sent some patches concerning UIM for CDMA modem but I think I am
>> missing something around modem.c so you can give them up :)
>>
>> For the moment, "modem.c" is designed for GSM modem, SIM atom is watched
>> to add a state watch to make modem progressing into pre_sim post_sim
>> online states etc...
>> However in the case of a CDMA modem we will have to watch another type
>> of atom (UIM for instance) and make the modem progressing into the
>> following states: pre_uim post_uim etc...
>>
>
> I think we need to understand in what ways UIM and SIMs are different.
> E.g. is it a manner of different EFs being present and their read order
> or something more fundamental.  To my understanding 3GPP just recycled
> the SIM specs from ETSI, so the fundamentals should be the same.
>

Looking to the R-UIM 3GPP2 specification (C.S0023), we can understand =

indeed that R-UIM can be considered as an extension of SIM.
In practice, we can retrieve the same information as for SIM, based =

obviously on different file ids (Emergency codes, preferred language, =

service table, etc...)

So far, we could imagine to extend the SIM atom to support also R-UIM =

architecture but what could be the purpose of this extension?
Here, the UIM atom is introduced originally to collect a subscriber =

identifier (MIN or True IMSI) in order to identify uniquely the =

cdma-connman interface.
But you seems to look for a more global solution. Are we looking to =

support also cdma for voice? cdma for card application tool kit?

Now, if we just need to collect this CDMA subscriber identifier, I think =

also excessive to introduce a specific atom for that.

Regards,

Philippe.

>> So what would you suggest to introduce CDMA modem into oFono?
>> Should we create another src/cdma_modem.c with its own watches, states
>> and cdma_atoms?
>> Or should we keep the current naming (e.g. pre_sim post_sim etc...) and
>> change current api to create cdma modem?
>> Something like: ofono_modem_create(cdma=3Dtrue/false) that is called from
>> udevng. Then this new modem would be tagged as cdma and we would look
>> for UIM atom intstead of SIM atom in case of cdma modem.
>>
>> What do you think about it?
>
> I think we need to learn a bit more about UIMs first.  Ideally I'd like
> to handle both in the sim atom if possible.  At least that would make
> sense from dual-mode device standpoint (e.g. something than can use CDMA
> and LTE)
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============8390436512765479855==--

