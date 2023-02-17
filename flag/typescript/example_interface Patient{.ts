// https://www.typescriptlang.org/play?ssl=22&ssc=1&pln=1&pc=1#code/JYOwLgpgTgZghgYwgAgApzMC4DeAoZQ5EOAWwgC5kBnMKUAcwBoCiATAewCMqQBXUl2gsiyOGygRq1KgEEJU6ngC+ePKEixEKeZOn5RtSRDBUjjEUQAWcPtX6lyUXgKFRLhcW2CYOJADYA-FR8IADWIBwA7iAA2gC6yCpqCH60yAAOGFjgyBTomNhgyAC8yAZEJORUAEQAKlYcpHDUNUxJopw8yACMAJwAHACs7ayeCtJUFaKERhAmtQBiEP5sRnAA+xBtYzM2dg5OVABMACweM14+wH5w-lSxAOQ9x4-tj2wwb8inp-EqygA3GogA
// code ist also part of the url :D

interface Patient{
    name: string,
    dob: number,
    adress: Adress
}

interface Adress{
    street: string,
    hausnummer: number,
    additional?: unknown[] 
}

const patient :Patient = {
    name: "Thomas", 
    dob: 1985, 
    adress: {
        street: "Feldstraße",
        hausnummer: 24,
        additional: ['12', 'df', 44]
}};

