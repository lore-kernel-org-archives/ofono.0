Content-Type: multipart/mixed; boundary="===============6330522910457149951=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 07/11] added stk_response_text_string for USSD result
Date: Thu, 02 Sep 2010 11:05:26 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0E4F4@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTim+N9mXH81UDsMmT2r6twrG2SiUaa-12uUFe9tW@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6330522910457149951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi,

> On irc we figured that the best hint about what is expected to be
returned is in the tests in 31.124.  +CUSD returns sms-like DCS, while
STK expects Cell Broadcast-like DCS and recommends using only the >
values 00, 04, 08, so there needs to be a translation from one to the
other (perhaps in stk.c in the ussd callback).  I think you'll also need
a length field in this struct as the data can contain 0s.

Will fix the code as per the comments.

Thanks and Regards,
jeevaka


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============6330522910457149951==--

