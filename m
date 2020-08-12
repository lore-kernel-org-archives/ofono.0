Content-Type: multipart/mixed; boundary="===============2911929034521637084=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/3] gprs: Quectel EC21 does not understand AT+CPSB
Date: Wed, 12 Aug 2020 09:44:09 -0500
Message-ID: <e637090b-8a4d-e5ef-028c-35052ec36f9b@gmail.com>
In-Reply-To: <20200812092057.w2h2oqc476x3cmxi@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2911929034521637084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

>> oFono driver interface is based on 27.007.  So that means values defined=
 in
>> 27.007 do not need to be 'converted'.  You can simply feed them in direc=
tly
>> if they follow 27.007.
> =

> Well, yes. I saw this. But unfortunately at this point what is expected
> are the 27.007 values from AT+CPSB defined in 7.29 (that EC21 quectel
> modem does not support) and I get the values from AT+CGREG defined in 7.2.
> =


Ok, I gotcha.  I see now what you're trying to do.

The problem is that +CGREG is not really the same as +CPSB.  +CGREG only re=
ports =

the capability of the cell, not the actual bearer being used.  This could b=
e for =

example due to signal strength being too low, etc.

If you look at the gprs driver, we never use +CGREG info this way and many =

modems have a vendor-specific unsolicited notification if +CPSB isn't suppo=
rted.

Since the Bearer is an optional property, maybe its just easier to omit it. =

Unless you know +CGREG information is the same as +CPSB on Quectel firmware=
...

Regards,
-Denis
--===============2911929034521637084==--

