Content-Type: multipart/mixed; boundary="===============3856534309866051851=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/6] STE-plugin
Date: Mon, 25 Jan 2010 21:07:21 +0100
Message-ID: <1264450041.11653.18.camel@violet>
In-Reply-To: <1264447534-2386-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3856534309866051851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> This is a new version of the STE-plugin patch set. Since last RFCv2 we ha=
ve
> stubbed out Voice Call and GPRS Context handling, changed patch order,
> cleanup some unnecessary includes, moved CAIF header files, and fixed =

> most other review comments (hopefully).

I applied all of your 6 patches. However there were some issues with
your submission.

First, please make sure you have a proper .gitconfig with your email
address and author set correct. That way we keep the GIT history clean
and readable. I had to fix this up on all your patches.

Second, please do proper commit messages. Either one line describes what
your are doing (will end up as Subject) or one line and then a body
describing the details. Check the GIT history for examples.

Third, please ensure that "make distcheck" builds properly. I had to fix
it up for the CAIF header files.

Regards

Marcel



--===============3856534309866051851==--

