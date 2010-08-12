Content-Type: multipart/mixed; boundary="===============8648096662079212037=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/10] Unregister AT notifiers when removing drivers
Date: Thu, 12 Aug 2010 07:04:43 -0400
Message-ID: <1281611083.12579.249.camel@localhost.localdomain>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8648096662079212037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> This series unregister AT notifiers in removing various AT modem drivers =
when modem goes to offline mode. Please review them.

just a heads up here that Denis and I talked about this. And we are
going to fix this inside GAtChat in the background for you. Trying to
fix this single handed in every atom driver is wrong.

This approach creates too much of a maintenance burden. And additional
code complexity and memory footprint doing it this way. So we have to
tackle it in a central place. And that is GAtChat.

Regards

Marcel



--===============8648096662079212037==--

