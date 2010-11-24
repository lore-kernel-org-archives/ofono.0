Content-Type: multipart/mixed; boundary="===============7635635525099218392=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Fix issue in call forwarding erase response handling
Date: Wed, 24 Nov 2010 02:10:53 -0800
Message-ID: <1290593454-22149-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7635635525099218392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

Issue observed in call forwarding feature information list parsing.
Due to this, isimodem reports Erase failure to the core even when the
Erase request is successfully handled by the network.

Considering the current logic, this is the fix that can be provided without
changes to other parts of the code. One of the other option is to initializ=
e the status in the calling function
and check its validity before the usage.

Regards,
Jeevaka

--===============7635635525099218392==--

