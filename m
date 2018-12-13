Content-Type: multipart/mixed; boundary="===============0901435707611489213=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 13 Dec 2018 11:31:03 -0600
Message-ID: <47a977c9-5c9f-54e5-0a19-432b61a0abed@gmail.com>
In-Reply-To: <CAKSBH7EkFXpKCKxKwRZ8WmxGyOm7a4DjZYQecnA77crnYCwiew@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0901435707611489213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> on the other hand, the sessions will be lost anyway, downloads and
> streaming interrupted, due to the change of mobile IP, even if
> the reboot would be fast.

Hey, I'm not fully convinced this is a good idea either ;)

But then to play devil's advocate:
- TCP can already deal with network interruptions
- Sane networks should issue the same IP
- This has already been done before with good success

Whether this is a good idea to do on the application processor is =

another question.

> =

>>
>> So if we do proceed with this feature, it should try pretty hard to
>> comply with the spirit of the cited section, even if it isn't complying
>> with it in a literal sense.
> =

> I don't agree with this.
> In the original intents, the PIN is shared through DBus,
> with quite some risk to disclose it to still other applications.

Please stop going off on tangents.  There is no more risk of exposing =

the PIN through D-Bus with a properly setup D-Bus security policy than =

any other IPC mechanism you can think of.  In fact it is probably safer =

than any IPC you can roll on your own.  If you want to discuss D-Bus =

security issues, take it to the D-Bus mailing list.

> =

> And then, if you want to restore the status as before the reboot,
> maybe there were other PINs or keys presented.
> Should they be stored and managed too?

Maybe? That is a question for the modem guys.

> =

> And in case of USB devices, they disappear and re-enum later.
> Should we think about storing the PIN non-volatile
> for supporting the feature for these devices???
> =

> And should we have a timeout for the reboot?
> =


timeouts are generally a bad idea since you can't control how long =

something takes.  But yes, maybe the cache should also have an =

expiration time set when the device is removed as well as the IMEI of =

the device such that only one IMEI/ICCID/PIN combination can exist.

Regards,
-Denis

--===============0901435707611489213==--

