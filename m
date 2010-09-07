Content-Type: multipart/mixed; boundary="===============0910643978427612194=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 2/2] stk and stkutil changes for Send USSD proactivecommand
Date: Tue, 07 Sep 2010 07:10:00 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0E9C8@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTimRZ9XVx+1FcFdhTwY4B97XFcqDnJj5XzVRvqkn@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0910643978427612194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Andrew,

> What is the meaning of that -1?  I don't see this value handled in
stkutil.
    If dcs is -1, then the text is assumed to be in UTF-8. Will add the
-1 handling in stkutil.h

> The rest of this patch looks okay to me, but you have some formatting
> issues: space after '(' above, and the first hunk removes empty lines.
> Other than that I think Denis might want you to split this patch into
stk patch and stkutil patch

> With regards to 1/2 he'll probably want one patch for atmodem, one for
isimodem, one for include, one for plugin, etc.  Also I think it's fair
to assume that the charset is > IRA and there's not need to account for
other possibilities, but other might have different opinions.  And I'm
not sure if the enum sms_charset values change should be =

> global, or translation should be done here in stk.c.

Since the USSD driver API is changed, its not possible to split the 1st
patch into one for atmodem, one for isimodem, one for include. Changes
in plugin and atutil can be delivered as a separate patch.

Thanks and Regards,
jeevaka


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============0910643978427612194==--

