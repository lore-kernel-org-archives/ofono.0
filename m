Content-Type: multipart/mixed; boundary="===============8767885147146779449=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] Don't use c++ keyword in public header files
Date: Tue, 25 Jan 2011 13:11:05 -0200
Message-ID: <AANLkTi=DcdFHC1yUE16-gVvXzU9nz-rhdeErq3TwvwqQ@mail.gmail.com>
In-Reply-To: <1295967523.1520.51.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8767885147146779449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 25, 2011 at 12:58 PM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
> Hi Lucas,
>
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *old, const char *new,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *p_old, const char *p_new,
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ofono_sim_lock_unlock_cb_t cb, void *data);
>> >> =C2=A0 =C2=A0 =C2=A0 void (*lock)(struct ofono_sim *sim, enum ofono_s=
im_password_type type,
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int enable, const char *passwd,
>> >
>> > why is this exactly a problem?
>>
>> I did it only because the file contains this:
>>
>> #ifdef __cplusplus
>> extern "C" {
>> #endif
>>
>>
>> So I thought someone might want to write a plugin in C++ or something
>> that includes sim.h
>
> and at that point you told the compiler that it is C code and not C++
> and it should be just fine.

This only works for the link phase, because of the name mangling in C++.

> I think it will compile just fine. Try to test it ;)

It doesn't. Example:

c.h
---
#ifdef __cplusplus
extern "C" {
#endif

int func(int *old, int *new);


#ifdef __cplusplus
}
#endif

---

cpp.cpp
---
#include <iostream>
#include "c.h"

using namespace std;


int main(int argc, char *argv[])
{
    int a =3D 2;
    int b =3D 3;


    cout << "Isso =C3=A9 um teste\n";

    return func(&a, &b);
}

---

$ g++ -c -o cpp.o cpp.cpp
In file included from cpp.cpp:2:0:
c.h:5:25: error: expected =E2=80=98,=E2=80=99 or =E2=80=98...=E2=80=99 befo=
re =E2=80=98new=E2=80=99



regards

Lucas De Marchi

--===============8767885147146779449==--

