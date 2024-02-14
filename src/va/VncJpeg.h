#pragma once

#include <vector>
#include <initializer_list>
#include <cinttypes>

namespace VncJpeg
{
    class Table : public std::vector< uint8_t >
    {
      public:
        Table( const std::initializer_list< uint8_t >& );
        void copyTo( void* to ) const;
    };

    class QuantizationTable : public std::vector< uint8_t >
    {
      public:
        QuantizationTable( const std::initializer_list< uint8_t >& );
        void copyTo( uint8_t* to ) const;

        uint8_t sequenced( int i ) const;
    };

    class Header
    {
      public:
        Header( int width, int height, int quality );

        const uint8_t* buffer() const { return m_buffer; }
        int count() const { return sizeof( m_buffer ); }

      private:

        void add2x4( uint8_t, uint8_t );
        void add8( uint8_t );

        void add16( uint16_t val );
        void addBytes( const std::vector< uint8_t >& );
        void addBytes( const char*, size_t );

        void add( uint8_t val, int numBits );

        int m_pos = 0;
        uint8_t m_buffer[624] = {};
    };

    const Table& dcCoefficientsLuminance();
    const Table& dcCoefficientsChroma();
    const Table& dcValues();

    const Table& acCoefficientsLuminance();
    const Table& acCoefficientsChroma();
    const Table& acValuesLuminance();
    const Table& acValuesChroma();

    const QuantizationTable& lumaQuantization();
    const QuantizationTable& chromaQuantization();
}
