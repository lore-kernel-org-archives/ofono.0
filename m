Content-Type: multipart/mixed; boundary="===============4108053723533362864=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Mon, 10 Jan 2011 10:27:33 -0600
Message-ID: <4D2B3375.1080907@gmail.com>
In-Reply-To: <201101101321.13315.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4108053723533362864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/10/2011 05:21 AM, R=C3=A9mi Denis-Courmont wrote:
> On Friday 07 January 2011 18:23:25 ext Denis Kenzior, you wrote:
>> The other question I have is whether we should report this at the
>> context level or at the ConnectionManager level.  Can different contexts
>> truly have different bearers?
> =

> At least for 3G with HS*PA, I believe we can. In my understanding, HSPA =

> channels are allocated per contexts. Correct me if I'm wrong.
> =


I don't know, to me it would not make sense to allocate different
bearers per context, but I'm not an RF engineer.  Do note that at least
several vendors provide extension commands that report the global active
bearer, not per context.  For instance, see the Ericsson *CPSB command...

Someone more knowledgeable would have to weigh in here...

Regards,
-Denis

--===============4108053723533362864==--

