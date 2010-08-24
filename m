Content-Type: multipart/mixed; boundary="===============6530858333457663824=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] Support text mode sms sending and receiving
Date: Tue, 24 Aug 2010 10:56:06 +0200
Message-ID: <1282640166.6841.10.camel@localhost.localdomain>
In-Reply-To: <1282631737-15873-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6530858333457663824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yong,

> ---
>  gatchat/gatchat.h |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)

so Denis has to give a final say on yes or no to these patches, but in
general gatchat.[ch] have to be submitted together. This applies to the
whole project.

Splitting patches into smaller pieces is not splitting them into one
patch per file. Split them into logical chunks and preferable that non
of them break the compilation.

Regards

Marcel



--===============6530858333457663824==--

