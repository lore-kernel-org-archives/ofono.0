Content-Type: multipart/mixed; boundary="===============4247896072810070758=="
MIME-Version: 1.0
From: Predon, Frederic <frederic.predon@intel.com>
Subject: Discussion on CTM enhancement 
Date: Wed, 22 Dec 2010 10:54:45 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934E645C02@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4247896072810070758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

As we are currently implementing the CTM modem driver for ifxmodem, I would=
 like to bring a couple of things in the discussion.
Today, patches for our modem driver are ready by before submitting them on =
the mailing list, I have 2 items to discuss:

1) First, it might a good proposal to merge the TextTelephony and the Audio=
Settings atoms. Enabling and disabling CTM on a platform require to configu=
re the audio settings on the modem side (audio routing parameters changes).=
 Today, in my patches, I have nearly the same code as the AudioSetting mode=
m driver for configuring the audio. Another proposal would be that the Text=
Telephony atom indicates to the AudioSetting atom that CTM is enable or dis=
able but that would be good also to merge the 2.
Any idea?

2) Secondly, I think that 2 properties can be added in the TextTelephony at=
om and/or the AudioSetting atom (or the "merged" atom described in 1). The =
first property is when the device receives an incoming CTM call. Even if th=
e type is still a voice call, upper layers should be notified that the inco=
ming is a TTY call to display some UI stuff or to turn on the TTY mode in c=
ase the device is not already TTY enabled (this is totally UI dependant but=
 at least we leave the flexibility to the UI to decide).
The second property is for MO calls. Remote user can accept the call as a T=
TY enable device or not. This is supported by the standard. In our case, we=
 are receiving unsolicited AT commands "CTM CALL" when the remote party has=
 accepted the call as a TTY enabled device and "NO CTM CALL" when the remot=
e has accepted the call but his device is not TTY enabled.

Let me know your thinking

Regards

Fred
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4247896072810070758==--

