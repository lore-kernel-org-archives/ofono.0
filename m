Content-Type: multipart/mixed; boundary="===============4321613820356451566=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ppp: implement MRU option
Date: Thu, 22 Apr 2010 17:12:10 +0200
Message-ID: <1271949130.22838.65.camel@localhost.localdomain>
In-Reply-To: <1271888790-5046-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4321613820356451566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> If the peer requests a MRU option, set the mtu for the network
> phase.  When we are in link establishment phase, we should
> continue to behave as if no option has been set and the peer
> should use the default MRU.
> =

> This option is required for the Huawei E160G modem.

can you also send a pppdump from this modem setup with a few IP packets
in for reference. I like to see what the Huawei modem does on LCP or
IPCP setup.

Regards

Marcel



--===============4321613820356451566==--

