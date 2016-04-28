Content-Type: multipart/mixed; boundary="===============8885375079862319745=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Question: How to activate a specific profile?
Date: Thu, 28 Apr 2016 09:50:00 -0500
Message-ID: <57222318.8010407@gmail.com>
In-Reply-To: <CAH4ZQwsZp=ZEWhhjeVEK8odVLu+ea+RH-d=m29XZ+g1fFUwmfA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8885375079862319745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 04/28/2016 07:30 AM, Enrico Sau wrote:
> Hi all,
> I have a Telit HE910 and I want to activate profile 3.
> I know oFono stores context internally, not in the modem, but I don't
> understand if I can activate a specific profile in the modem.
>

Sounds like this profile management is Telit modem specific.  There is =

no way to trigger it at the oFono D-Bus API level.

You might be able to add a Telit specific modem-API or have the telit =

modem driver activate the profile you need.

Regards,
-Denis


--===============8885375079862319745==--

