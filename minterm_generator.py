class MintermGenerator:
    def __init__(self, predicates):
        self.predicates = predicates

    def generate_minterms(self):
        minterms = []
        num_predicates = len(self.predicates)

        # Generate all possible combinations of predicates
        for i in range(1 << num_predicates):  # 2^n combinations
            minterm = []
            for j in range(num_predicates):
                if (i & (1 << j)) > 0:  # Check if j-th bit is set
                    minterm.append(self.predicates[j])
            minterms.append(minterm)

        return minterms


# Example usage
if __name__ == "__main__":
    predicates = ['A', 'B', 'C']
    generator = MintermGenerator(predicates)
    minterms = generator.generate_minterms()
    print(minterms)
