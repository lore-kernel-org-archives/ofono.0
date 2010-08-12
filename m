Content-Type: multipart/mixed; boundary="===============7251348054836767117=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 10/16] gprs: Add ofono_gprs_create_context method
Date: Thu, 12 Aug 2010 07:57:38 -0400
Message-ID: <1281614258.12579.272.camel@localhost.localdomain>
In-Reply-To: <1281493601-14351-11-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7251348054836767117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> DUN server may create one primary context if none of contexts existing
> on the GPRS atom.

so Denis and I had a chat about this. And we agreed that oFono core
should just create one Internet context if none exists. If the plugin
driver registers a GPRS atom, we should just create one context anyway.
ConnMan requires this anyway and it makes sense. We can also go one step
ahead and fail to remove this default Internet context. It should be
present all the time.

Regards

Marcel



--===============7251348054836767117==--

