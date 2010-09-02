Content-Type: multipart/mixed; boundary="===============1530708653752604042=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: Patch: "Added missing DCS handling in stkutil and stk" Description
Date: Thu, 02 Sep 2010 17:16:09 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0E5D5@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1530708653752604042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

 The following patch "Added missing DCS handling in stkutil and stk"
handles the missing dcs case as:

 As per 3GPP TS 31.111 section 8.15 Text string structure requires dcs
and text string to be sent. Current stkutil function and data structure
is missing the dcs information.
 In this patch, we handle the case where dcs will be a value other than
-1, yesno and packed values are false. This text string structure is
used in Terminal response of Get Inkey, Get Input and Send USSD.

Regards,
jeevaka


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============1530708653752604042==--

