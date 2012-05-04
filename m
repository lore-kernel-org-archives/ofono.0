Content-Type: multipart/mixed; boundary="===============4734526636484800083=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: mms: next steps
Date: Fri, 04 May 2012 17:18:54 +0200
Message-ID: <4FA3F35E.2070008@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4734526636484800083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Now that mms' TODO is almost empty (I've sent a set of patches yesterday =

that implement the last entry of the TODO).
What should we add to release a first version of MMS ?

What's already in place :
- MMS submission,
- MMS reception (automatic retrieval support),
- MMS storage with status support,
- (Basic) error management with transaction completion on restart.

What can be added :
- Manual retrieval support for MMS reception,
- Delivery report support (M-Delivered.ind),
- Enhance D-Bus API (DeleteMessages(), DeleteConversation() ...)
- or something else ...

How do you see the next actions to take?

Thanks in advance for your feedback.
Best regards,

Ronald

--===============4734526636484800083==--

