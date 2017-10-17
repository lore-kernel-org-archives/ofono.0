Content-Type: multipart/mixed; boundary="===============5850389852006638554=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/1] qmi: support SMS receive on Quectel EC21
Date: Tue, 17 Oct 2017 09:16:39 +0200
Message-ID: <f8d6bb37-b59b-cea7-5ef9-56b0e7072e14@southpole.se>
In-Reply-To: <20171016160638.237f89f2@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5850389852006638554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 10/16/2017 04:07 PM, Alexander Couzens wrote:
> Hi Jonas,
>
> I'm working on Gobi2000 sms support atm and having the same problem.
> Could you create a raw read request function? For the Gobi2000 I'll
> need the same function on powering to clean up the whole storage.

Could you explain what you are trying to do here?  Why would you clear =

the SMS storage every time the modem powers up?

I also don't see that ofono actually supports deleting messages from the =

modem's storage... if you know how this is supposed to work, please =

enlighten me.

/Jonas

>
> Best,
> Alexander



--===============5850389852006638554==--

